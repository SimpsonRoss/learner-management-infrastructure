# AWS Region

variable "region" {
  description = "value of the region"
  type = string
}

# ------------------------------------------------------------

# Credential variables

variable "secret_username" {
  type = string
  description = "The Secret name of the username in AWS Secrets Manager"
}

variable "secret_password" {
  type = string
  description = "The Secret name of the password in AWS Secrets Manager"
}

variable "username_secretkey" {
  description = "The key name of the Secret key for the username in AWS Secrets Manager"
  type = string
}

variable "password_secretkey" {
  description = "The key name of the Secret key for the password in AWS Secrets Manager"
  type = string
}

variable "database_name" {
  description = "The name of the database"
  type = string
}

# ------------------------------------------------------------

# Names of the resources

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "subnet_group_name" {
  description = "The name of the subnet group for the db"
  type        = string
}

variable "igw_name" {
  description = "The name of the internet gateway"
  type        = string
}

variable "route_table_name" {
  description = "The name of the route table"
  type        = string
}

variable "sg_name" {
  description = "The name of the security group"
  type = string
}

# ------------------------------------------------------------

# CIDR blocks and availability zones

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet_cidrs" {
  description = "List of subnet CIDR blocks"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

# ------------------------------------------------------------

# RDS set up

variable "RDS_setup" {
  description = "An object containing the RDS setup"
  type        = object({
    allocated_storage    = number
    storage_type         = string
    engine               = string
    engine_version       = string
    instance_class       = string
  })
}