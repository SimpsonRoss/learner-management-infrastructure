output "rds_instance_endpoint" {
  value = aws_db_instance.mydb.endpoint
}

output "rds_security_group_id" {
  value = aws_security_group.my_sg.id
}