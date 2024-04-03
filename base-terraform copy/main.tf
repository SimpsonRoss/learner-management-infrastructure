# Network Configuration Module

module "networking" {
  source          = "./modules/networking"
  cidr_block      = var.cidr_block
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  vpc_name        = var.vpc_name
  cluster_name    = var.cluster_name
}

# ------------------------------------------------------------

# EKS Cluster Configuration Module

module "eks_cluster" {
  source              = "./modules/containerisation"
  cluster_version     = var.cluster_version
  vpc_id              = module.networking.vpc_id
  private_subnets     = module.networking.private_subnets
  cluster_name        = var.cluster_name
  eks_node_group_name = var.eks_node_group_name
}
