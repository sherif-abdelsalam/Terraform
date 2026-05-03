variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnets" {
  type = list(object({
    name      = string
    cidr      = string
    az        = string
    public_ip = bool
  }))
}