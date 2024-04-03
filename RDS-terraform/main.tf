# Define the provider

provider "aws" {
  region = var.region
}

# ------------------------------------------------------------

# Create the VPC, subnets, route table, and internet gateway

# module "vpc" {
#   source = "./modules/networking"
#   vpc_cidr_block     = var.vpc_cidr_block
#   vpc_name           = var.vpc_name
#   subnet_group_name  = var.subnet_group_name
#   igw_name           = var.igw_name
#   route_table_name   = var.route_table_name
#   subnet_cidrs       = var.subnet_cidrs
#   availability_zones = var.availability_zones
# }

# ------------------------------------------------------------

# Create a security group for the RDS instance

# module "security" {
#   source = "./modules/security"
#   sg_name = var.sg_name
#   vpc_id  = module.vpc.vpc_id
# }

# ------------------------------------------------------------

# Create the RDS instance

# module "rds" {
#   source = "./modules/rds"
#   allocated_storage    = var.RDS_setup.allocated_storage
#   storage_type         = var.RDS_setup.storage_type
#   engine               = var.RDS_setup.engine
#   engine_version       = var.RDS_setup.engine_version
#   instance_class       = var.RDS_setup.instance_class
#   db_name              = var.database_name
#   username_secret_name = var.secret_username
#   password_secret_name = var.secret_password
#   password_secretkey   = var.password_secretkey
#   username_secretkey   = var.username_secretkey
#   db_subnet_group_name = module.vpc.subnet_group_name
#   sg_id                = module.security.sg_id
# }

# ------------------------------------------------------------

# Create elastic container registry 

module "ECR" {
  source = "./modules/ECR"
  container_name = var.container_name
  mutability = var.mutability
  scan_on_push = var.scan_on_push
}