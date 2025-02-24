
provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "server-count" {
  ami           = " ami-0b5eea76982371e5b"
  instance_type = "t2.micro"
  count         = 4

  tags = {
    Name = "count-on-example-servers-${count.index}"
  }
}

output "public_ip" {
  value = aws_instance.server-count[*].public_ip
}
