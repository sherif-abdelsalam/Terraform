output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = {
    public_subnet = aws_subnet.all_subnets["public-subnet"].id
    private_subnet = aws_subnet.all_subnets["private-subnet"].id
  }
}