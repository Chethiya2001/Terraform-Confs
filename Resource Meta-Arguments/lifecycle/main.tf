terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.50.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myec2" {
  instance_type = "t2.micro"
  ami           = "ami-0c1a7f89451184c8b"

  lifecycle {
    prevent_destroy = true

  }

  tags = {
    Name = "MyFirstInstance"
  }
}
