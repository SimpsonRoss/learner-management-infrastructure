variable "vpc_name" {
  description = "Name of the VPC to place cluster in"
  type        = string
}

variable "cluster_name" {
  description = "Name you wish to give to your EKS cluster"
  type        = string     
}

variable "region" {
  description = "AWS region"
  type        = string
}