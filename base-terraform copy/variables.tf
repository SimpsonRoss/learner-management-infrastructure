# AWS Region

variable "region" {
  description = "AWS region"
  type        = string
}

# ------------------------------------------------------------

# VPC Configuration

variable "vpc_name" {
  description = "Name of the VPC to place cluster in"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

# ------------------------------------------------------------

# EKS Cluster Configuration

variable "cluster_name" {
  description = "Name you wish to give to your EKS cluster"
  type        = string     
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
}

variable "eks_node_group_name" {
  description = "The name of the EKS node group"
  type        = string
}