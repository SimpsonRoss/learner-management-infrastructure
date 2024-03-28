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