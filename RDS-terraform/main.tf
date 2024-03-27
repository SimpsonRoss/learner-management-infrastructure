provider "aws" {
  region = "eu-west-2"
}

module "vpc" {
  source = "./modules/vpc"

  cidr_block = "10.0.0.0/16"
  vpc_name   = "my-vpc"
  subnets = [
    {
      cidr = "10.0.1.0/24",
      az   = "eu-west-2a",
      name = "my-subnet1"
    },
    {
      cidr = "10.0.2.0/24",
      az   = "eu-west-2b",
      name = "my-subnet2"
    },
    {
      cidr = "10.0.3.0/24",
      az   = "eu-west-2c",
      name = "my-subnet3"
    }
  ]
}

module "security" {
  source = "./modules/security"

  sg_name = "my-security-group"
  vpc_id  = module.vpc.vpc_id
}

module "rds" {
  source = "./modules/rds"

  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "15.3"
  instance_class       = "db.t3.micro"
  db_name              = "mydatabase"
  username_secret_name = var.secret_username
  password_secret_name = var.secret_password
  password_secretkey   = var.password_secretkey
  username_secretkey   = var.username_secretkey
  db_subnet_group_name = module.vpc.subnet_group_name
  sg_id                = module.security.sg_id
  publicly_accessible  = true
}
