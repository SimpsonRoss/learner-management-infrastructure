variable "allocated_storage" {
  description = "The allocated storage size for the RDS instance"
  type        = number
}

variable "storage_type" {
  description = "The storage type for the RDS instance"
  type        = string
}

variable "engine" {
  description = "The database engine to use"
  type        = string
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "username_secret_name" {
  description = "The Secrets Manager secret name for the database username"
  type        = string
}

variable "password_secret_name" {
  description = "The Secrets Manager secret name for the database password"
  type        = string
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
}

variable "sg_id" {
  description = "The ID of the security group to associate with the RDS instance"
  type        = string
}

variable "publicly_accessible" {
  description = "Whether the DB should be publicly accessible"
  type        = bool
}

variable "username_secretkey" {
  description = "The key name of the Secret key for the username in AWS Secrets Manager"
  type = string
}

variable "password_secretkey" {
  description = "The key name of the Secret key for the password in AWS Secrets Manager"
  type = string
}