# module "network" {
#   source = "./modules/network"
#   subnets = var.subnets
# }

# module "security_groups" {
#   source = "./modules/security-groups"
#   vpc_id = module.network.vpc_id
#   vpc_cidr = module.network.vpc_cidr
# }

# module "machines" {
#   source = "./modules/machines"
#   instance_type = var.instance_type
#   security_group_ids = module.security_groups.security_group_ids
#   subnet_ids = module.network.subnet_ids
# }


# module "databases-mysql-escashe" {
#   source = "./modules/databases"
#   db_username = var.db_username
#   db_password = var.db_password
# }




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

  owners = ["099720109477"]
}

resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"

  key_name               = "my-key"

  associate_public_ip_address = true

  tags = {
    Name = "jenkins-bastion"
  }
}