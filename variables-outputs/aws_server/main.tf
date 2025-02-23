terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "instance_type" {
  type        = string
  description = "value Type of instance type"
  #sensitive = true
  validation {
    condition     = can(regex("^t2.", var.instance_type))
    error_message = "The instance type must be t3.."
  }
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


locals {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
}
resource "aws_instance" "app_server" {
  ami           = local.ami
  instance_type = local.instance_type

  tags = {
    Name = "ServerInstance"
  }
}
output "public_ip" {
  value = aws_instance.app_server.public_ip
}
