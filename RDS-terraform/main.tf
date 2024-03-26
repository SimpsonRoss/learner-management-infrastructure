provider "aws" {
  region = "eu-west-2" 
}

// SECRETS ------------------------------

data "aws_secretsmanager_secret" "username" {
  name = "POSTGRES_USERNAME2"
}

data "aws_secretsmanager_secret" "password" {
  name = "POSTGRES_PASSWORD2"
}

data "aws_secretsmanager_secret_version" "current_username" {
  secret_id = data.aws_secretsmanager_secret.username.id
}

data "aws_secretsmanager_secret_version" "current_password" {
  secret_id = data.aws_secretsmanager_secret.password.id
}

// SECRETS ------------------------------


locals {
  db_password = jsondecode(data.aws_secretsmanager_secret_version.current_password.secret_string)
  db_username = jsondecode(data.aws_secretsmanager_secret_version.current_username.secret_string)
}

resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "my_subnet1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-2a"

  tags = {
    Name = "my-subnet1"
  }
}

resource "aws_subnet" "my_subnet2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-2b"

  tags = {
    Name = "my-subnet2"
  }
}

resource "aws_db_subnet_group" "my_subnet_group" {
  name       = "my-subnet-group"
  subnet_ids = [aws_subnet.my_subnet1.id, aws_subnet.my_subnet2.id]

  tags = {
    Name = "My DB Subnet Group"
  }
}

resource "aws_security_group" "my_sg" {
  name        = "my-security-group"
  description = "Allow PostgreSQL"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-internet-gateway"
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "my-route-table"
  }
}

resource "aws_route_table_association" "my_subnet1_association" {
  subnet_id      = aws_subnet.my_subnet1.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table_association" "my_subnet2_association" {
  subnet_id      = aws_subnet.my_subnet2.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_db_instance" "mydb" {
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = "15.3"
  instance_class          = "db.t3.micro"
  db_name                 = "mydatabase"
  username                = local.db_username.username
  password                = local.db_password.password
  db_subnet_group_name    = aws_db_subnet_group.my_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.my_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = true
}

