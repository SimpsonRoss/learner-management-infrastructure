variable "secret_username" {
  type = string
  description = "The Secret name of the username in AWS Secrets Manager"
}

variable "secret_password" {
  type = string
  description = "The Secret name of the password in AWS Secrets Manager"
}

variable "username_secretkey" {
  description = "The key name of the Secret key for the username in AWS Secrets Manager"
  type = string
}

variable "password_secretkey" {
  description = "The key name of the Secret key for the password in AWS Secrets Manager"
  type = string
}