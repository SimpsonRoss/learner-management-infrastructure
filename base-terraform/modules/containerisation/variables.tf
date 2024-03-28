# Names of the resources

variable "cluster_name" {
  description = "The name of the EKS cluster - used for identifying network aspects with tags"
  type        = string
}

variable "eks_node_group_name" {
  description = "The name of the EKS node group"
  type        = string
}

# ------------------------------------------------------------

# VPC ID and Subnet IDs

variable "vpc_id" {
  description = "The ID of the VPC to place the cluster id"
  type        = string
}

variable "private_subnets" {
  description = "Private Subnet IDs for the cluster"
  type        = list(string)
}

# ------------------------------------------------------------

# Cluster version

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
}