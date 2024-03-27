output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.my_vpc.id
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = aws_subnet.my_subnet[*].id
}

output "subnet_group_name" {
  description = "Name of the subnet group"
  value = aws_db_subnet_group.my_subnet_group.name
}