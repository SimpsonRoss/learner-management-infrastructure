output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.karv_db_vpc.id
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = aws_subnet.karv_db_subnet[*].id
}

output "subnet_group_name" {
  description = "Name of the subnet group"
  value = aws_db_subnet_group.karv_subnet_group.name
}