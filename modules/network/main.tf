
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}


resource "aws_subnet" "all_subnets" {
  for_each = {for s in var.subnets : s.name => s}
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.public_ip


  tags = {
    Name = each.value.name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}
# Public Associations
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.all_subnets["public-subnet"].id
  route_table_id = aws_route_table.public_rt.id
}

###############################
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  ## if we have NAT gateway, we will add route to NAT gateway here
  #   route = {
  #     cidr_block = "0.0.0.0/0"
  #     gatway_id = aws_nat_gateway.nat.id
  #   }

  tags = {
    Name = "private-route-table"
  }
}


# Private Associations
resource "aws_route_table_association" "private_assoc" {
  subnet_id      =  aws_subnet.all_subnets["private-subnet"].id
  route_table_id = aws_route_table.private_rt.id
}
