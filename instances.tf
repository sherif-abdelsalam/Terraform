# 7- create ec2(bastion) in public subnet with security group from 7

resource "aws_instance" "bastion" {
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_public.id]

  user_data = <<-EOF
                #!/bin/bash
                dnf update -y
                dnf install -y nginx
                systemctl start nginx
                systemctl enable nginx
                EOF
                
  tags = {
    Name = "bastion"
  }
}

# 8- create ec2(application) private subnet with security group from 8
resource "aws_instance" "application" {
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_and_3000_vpc.id]

  tags = {
    Name = "application"
  }
}