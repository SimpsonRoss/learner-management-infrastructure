# Region Configuration

region = "eu-west-2"

# ------------------------------------------------------------

# Credential Variables

secret_username   = "POSTGRES_USERNAME2"
secret_password   = "POSTGRES_PASSWORD2"
username_secretkey = "username"
password_secretkey = "password"

# ------------------------------------------------------------

# Database Configuration
database_name = "mydatabase"

# RDS Setup
RDS_setup = {
  allocated_storage = 20
  storage_type      = "gp2"
  engine            = "postgres"
  engine_version    = "15.3"
  instance_class    = "db.t3.micro"
}

# ------------------------------------------------------------

# VPC Configuration

vpc_name          = "karv_db_vpc"
vpc_cidr_block    = "10.0.0.0/16"
subnet_group_name = "karv-subnet-group"
igw_name          = "karv-igw"
route_table_name  = "karv-route-table"
sg_name           = "karv-security-group"

# ------------------------------------------------------------

# Network Configuration
subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24",
  "10.0.3.0/24"
]

availability_zones = [
  "eu-west-2a",
  "eu-west-2b",
  "eu-west-2c"
]