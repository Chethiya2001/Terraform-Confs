output "instance_public_ip" {
  value       = aws_instance.update_ubuntu_server.public_ip
  description = "The public IP address of the main ec2 server instance."
}
