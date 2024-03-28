# Names of the resources

variable "vpc_name" {
  description = "Name of the VPC to place cluster in"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster - used for identifying network aspects with tags"
  type        = string
}

# ------------------------------------------------------------

# CIDR blocks and subnet IDs

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}