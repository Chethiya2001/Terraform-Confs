provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

resource "aws_instance" "foo" {
  provider      = aws.west
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

resource "aws_instance" "bar" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

output "public_ip" {
  value = aws_instance.foo.public_ip
}

output "public_ip2" {
  value = aws_instance.bar.public_ip
}
