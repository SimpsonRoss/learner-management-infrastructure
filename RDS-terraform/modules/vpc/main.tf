resource "aws_vpc" "my_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "my_subnet" {
  count                   = length(var.subnets)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnets[count.index].cidr
  availability_zone       = var.subnets[count.index].az

  tags = {
    Name = var.subnets[count.index].name
  }
}

resource "aws_db_subnet_group" "my_subnet_group" {
  name       = "my-subnet-group"
  subnet_ids = [aws_subnet.my_subnet[0].id, aws_subnet.my_subnet[1].id, aws_subnet.my_subnet[2].id]

  tags = {
    Name = "My DB Subnet Group"
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
  subnet_id      = aws_subnet.my_subnet[0].id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table_association" "my_subnet2_association" {
  subnet_id      = aws_subnet.my_subnet[1].id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table_association" "my_subnet3_association" {
  subnet_id      = aws_subnet.my_subnet[2].id
  route_table_id = aws_route_table.my_route_table.id
}

