output "rds_instance_endpoint" {
  description = "The connection endpoint for the RDS instance."
  value       = module.rds.db_endpoint
}

output "rds_security_group_id" {
  description = "The ID of the security group associated with the RDS instance."
  value       = module.security.sg_id
}


