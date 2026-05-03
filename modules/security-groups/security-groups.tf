# 7 - Security Group: Allow SSH from anywhere
resource "aws_security_group" "allow_ssh_public" {
  name   = "allow_ssh_public"
  vpc_id = var.vpc_id
  tags = {
    Name = "allow_ssh_public"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_anywhere" {
  security_group_id = aws_security_group.allow_ssh_public.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_from_anywhere" {
  security_group_id = aws_security_group.allow_ssh_public.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_public" {
  security_group_id = aws_security_group.allow_ssh_public.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # all traffic
}


# 8 - Security Group: Allow SSH and Port 3000 from VPC CIDR only
resource "aws_security_group" "allow_ssh_and_3000_vpc" {
  name   = "allow_ssh_and_3000_vpc"
  vpc_id = var.vpc_id

  tags = {
    Name = "allow_ssh_and_3000_vpc"
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_vpc" {
  security_group_id = aws_security_group.allow_ssh_and_3000_vpc.id
  cidr_ipv4         = var.vpc_cidr
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_ingress_rule" "allow_3000_from_vpc" {
  security_group_id = aws_security_group.allow_ssh_and_3000_vpc.id
  cidr_ipv4         = var.vpc_cidr
  from_port         = 3000
  ip_protocol       = "tcp"
  to_port           = 3000
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_vpc" {
  security_group_id = aws_security_group.allow_ssh_and_3000_vpc.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}