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

variable "db_username" {
  description = "The username for the database."
  type        = string
}

variable "db_password" {
  description = "The password for the database."
  type        = string
  sensitive   = true
}