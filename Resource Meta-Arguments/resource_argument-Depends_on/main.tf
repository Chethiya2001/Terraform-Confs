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

resource "aws_s3_bucket" "bucket" {
  bucket = "112121111-depends-on-bucket"
  depends_on = [
    aws_instance.myserver
  ]
}
resource "aws_instance" "myserver" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  # depends_on = [
  #   aws_s3_bucket.bucket
  # ]

  tags = {
    Name = "depends-on-example"
  }

}

output "public_ip" {
  value = aws_instance.myserver.public_ip
}
