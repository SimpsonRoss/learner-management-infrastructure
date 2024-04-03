# Security Group Configuration for PostgreSQL

resource "aws_security_group" "my_sg" {
  name        = var.sg_name
  description = "Allow PostgreSQL"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}