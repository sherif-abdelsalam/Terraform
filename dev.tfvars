vpc_cidr = "172.16.0.0/16"

# public_subnet = "172.16.1.0/24"

# private_subnet = "172.16.11.0/24"

region = "eu-central-1"

instance_type = "t3.micro"

subnets = [
    {
        name = "public-subnet"
        cidr = "10.0.1.0/24"
        az = "eu-central-1a"
        public_ip = true
    },
    {
        name = "private-subnet"
        cidr = "10.0.11.0/24"
        az = "eu-central-1a"
        public_ip = false
    }
]


db_username = "sherif"
db_password = "securepassword"