# output "rds_instance_endpoint" {
#   value = aws_db_instance.mydb.endpoint
# }

# output "rds_security_group_id" {
#   value = aws_security_group.my_sg.id
# }

output "rds_instance_endpoint" {
  description = "The connection endpoint for the RDS instance."
  value       = module.rds.db_endpoint
}

output "rds_security_group_id" {
  description = "The ID of the security group associated with the RDS instance."
  value       = module.security.sg_id
}


