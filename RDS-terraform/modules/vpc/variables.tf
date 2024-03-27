variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "subnets" {
  description = "A list of subnets within the VPC"
  type = list(object({
    cidr = string
    az   = string
    name = string
  }))
}
