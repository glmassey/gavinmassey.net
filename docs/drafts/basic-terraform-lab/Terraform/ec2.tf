provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0fc5d935ebf8bc3bc" # Replace with your AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id # Reference to your subnet in the new VPC
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  key_name      = "key-pair-for-my-lab"  # The name of your key pair

  tags = {
    Name = "MyEC2Instance"
  }
}
