
variable "instance_type" {
  type = string
}

variable "security_group_ids" {
  type = map(string)
}

variable "subnet_ids" {
  type = map(string)
}