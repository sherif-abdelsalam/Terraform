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


module "databases-mysql-escashe" {
  source = "./modules/databases"
  db_username = var.db_username
  db_password = var.db_password
}