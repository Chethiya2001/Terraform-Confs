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

resource "aws_instance" "myec2" {
  ami           = "ami-0f5ee92e2d24d1181"
  instance_type = "t2.micro"

  for_each = {
    nano  = "t2.nano",
    micro = "t2.micro",
    large = "t2.large"
  }


  tags = {
    Name = "myec2"
  }
}
output "public_ip" {
  value = values(aws_instance.myec2)[*].public_ip
}
