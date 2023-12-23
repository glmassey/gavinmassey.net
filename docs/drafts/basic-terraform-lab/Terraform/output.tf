# Output the public IP of the EC2 instance
output "instance_public_ip" {
  value       = aws_instance.my_instance.public_ip
  description = "The public IP address of the EC2 instance."
}

# Output the private IP of the EC2 instance
output "instance_private_ip" {
  value       = aws_instance.my_instance.private_ip
  description = "The private IP address of the EC2 instance."
}

# Output the ID of the EC2 instance
output "instance_id" {
  value       = aws_instance.my_instance.id
  description = "The ID of the EC2 instance."
}

# Output the VPC ID
output "vpc_id" {
  value       = aws_vpc.my_vpc.id
  description = "The ID of the VPC."
}

# Output the subnet ID
output "subnet_id" {
  value       = aws_subnet.my_subnet.id
  description = "The ID of the subnet."
}

# Output the security group ID
output "security_group_id" {
  value       = aws_security_group.my_security_group.id
  description = "The ID of the security group."
}

