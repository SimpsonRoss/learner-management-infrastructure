module "networking" {
    source          = "./modules/networking"

    vpc_name        = var.vpc_name
    cluster_name    = var.cluster_name
}

module "eks_cluster" {
    source          = "./modules/containerisation"

    vpc_id          = module.networking.vpc_id
    private_subnets = module.networking.private_subnets
    cluster_name    = var.cluster_name
}