output "security_group_ids" {
  value = {
    allow_ssh_public = aws_security_group.allow_ssh_public.id
    allow_ssh_and_3000_vpc = aws_security_group.allow_ssh_and_3000_vpc.id
  }
}