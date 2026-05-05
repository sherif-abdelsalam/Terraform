
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


# 7- create ec2(bastion) in public subnet with security group from 7

resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_ids["public_subnet"]
  vpc_security_group_ids = [var.security_group_ids["allow_ssh_public"]]

  user_data = <<-EOF
                #!/bin/bash
                apt update -y
                apt install -y nginx
                systemctl start nginx
                systemctl enable nginx
                EOF

  tags = {
    Name = "bastion"
  }

  provisioner "local-exec" {
    command = "echo Bastion Public IP: ${self.public_ip}"
  }
}

# 8- create ec2(application) private subnet with security group from 8
resource "aws_instance" "application" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_ids["private_subnet"]
  vpc_security_group_ids = [var.security_group_ids["allow_ssh_and_3000_vpc"]]

  tags = {
    Name = "application"
  }
}
