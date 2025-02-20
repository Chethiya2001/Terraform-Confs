
resource "aws_instance" "update_ubuntu_server" {
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = var.instance_type
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
  tags = {
    Name = "MyServer-${local.project_name}"
  }
}
# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"
#   providers = {
#     aws = aws.west
#   }
#   name = "my-vpc"
#   cidr = "10.0.0.0/16"

#   azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets  = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]

#   enable_nat_gateway = false
#   enable_vpn_gateway = false

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }

