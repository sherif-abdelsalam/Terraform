variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "region" {
  type = string
}

variable "instance_type" {
  type = string
}


variable "subnets" {
  type = list(object({
    name      = string
    cidr      = string
    az        = string
    public_ip = bool
  }))
}