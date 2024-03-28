# Region Configuration

region = "eu-west-2"

# ------------------------------------------------------------

# VPC Configuration

vpc_name     = "karv-eks-vpc"
cidr_block   = "10.0.0.0/16"

# Subnets
private_subnets = [
  "10.0.1.0/24", 
  "10.0.2.0/24", 
  "10.0.3.0/24"
]
public_subnets = [
  "10.0.4.0/24", 
  "10.0.5.0/24", 
  "10.0.6.0/24"
]

# ------------------------------------------------------------

# EKS Cluster Configuration

cluster_name = "karv-cluster"
cluster_version = "1.27"
eks_node_group_name = "karv-node-group"