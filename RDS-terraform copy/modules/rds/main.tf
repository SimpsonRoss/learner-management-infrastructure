# Fetch the secrets from AWS Secrets Manager

data "aws_secretsmanager_secret" "username" {
  name = var.username_secret_name
}

data "aws_secretsmanager_secret" "password" {
  name = var.password_secret_name
}

# ------------------------------------------------------------

# Fetch the current secret values

data "aws_secretsmanager_secret_version" "current_username" {
  secret_id = data.aws_secretsmanager_secret.username.id
}

data "aws_secretsmanager_secret_version" "current_password" {
  secret_id = data.aws_secretsmanager_secret.password.id
}

# ------------------------------------------------------------

# Define local variables for the decoded secrets

locals {
  db_password = jsondecode(data.aws_secretsmanager_secret_version.current_password.secret_string)
  db_username = jsondecode(data.aws_secretsmanager_secret_version.current_username.secret_string)
}

# ------------------------------------------------------------

# Create the RDS instance

resource "aws_db_instance" "mydb" {
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  db_name                 = var.db_name
  username                = jsondecode(data.aws_secretsmanager_secret_version.current_username.secret_string)[var.username_secretkey]
  password                = jsondecode(data.aws_secretsmanager_secret_version.current_password.secret_string)[var.password_secretkey]
  db_subnet_group_name    = var.db_subnet_group_name
  vpc_security_group_ids  = [var.sg_id]
  skip_final_snapshot     = true
  publicly_accessible     = true
}

