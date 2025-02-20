terraform {
  cloud {
    organization = "cloud-init-example"
    workspaces {
      name = "demo_01"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  #profile = "default"

}
data "template_file" "user_data" {
  template = file("./userdata.yaml")
}
data "aws_vpc" "main" {
  id = "vpc-023c807323c17ba5d"
}
resource "aws_security_group" "sg_myserver" {
  name        = "myserver-sg"
  description = "Allow inbound HTTP and SSH traffic"

  # Ingress (Allow inbound traffic)
  ingress = [
    {
      description      = "HTTP"
      protocol         = "tcp"
      from_port        = 80
      to_port          = 80
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "SSH"
      protocol         = "tcp"
      from_port        = 22
      to_port          = 22
      cidr_blocks      = ["111.223.184.18/32"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  # Egress (Allow all outbound traffic)
  egress = [
    {
      description      = "Allow all outbound traffic"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "Terraform-SecurityGroup"
  }
}




resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "#"
}


resource "aws_instance" "update_ubuntu_server" {
  ami                    = "ami-04b4f1a9cf54c11d0"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.sg_myserver.id]
  user_data              = data.template_file.user_data.rendered
  tags = {
    Name = "MyServer-${local.project_name}"
  }
}
locals {
  project_name = "cloud-init"

}
output "server_ip" {
  value = aws_instance.update_ubuntu_server.public_ip
}
