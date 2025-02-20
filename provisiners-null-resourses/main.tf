terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

}
provider "aws" {
  region  = "us-east-1"
  profile = "default"

}
resource "aws_instance" "update_ubuntu_server" {
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  tags = {
    Name = "MyServer-${local.project_name}"
  }
}
resource "null_resource" "status" {
  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.update_ubuntu_server.id}"
  }
  depends_on = [
    aws_instance.update_ubuntu_server
   ]

}
locals {
  project_name = "my"

}
