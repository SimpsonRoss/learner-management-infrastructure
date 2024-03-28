# Create the main VPC for the database

resource "aws_vpc" "karv_db_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

# ------------------------------------------------------------

# Create subnets for the database in specified availability zones

resource "aws_subnet" "karv_db_subnet" {
  count = length(var.subnet_cidrs)

  vpc_id            = aws_vpc.karv_db_vpc.id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.vpc_name}-subnet-${count.index + 1}"
  }
}

# ------------------------------------------------------------

# Create a DB subnet group comprising the above subnets

resource "aws_db_subnet_group" "karv_subnet_group" {
  subnet_ids = aws_subnet.karv_db_subnet[*].id

  tags = {
    Name =  var.subnet_group_name
  }
}

# ------------------------------------------------------------

# Create an Internet Gateway for the VPC to enable internet access

resource "aws_internet_gateway" "karv_igw" {
  vpc_id = aws_vpc.karv_db_vpc.id

  tags = {
    Name = var.igw_name
  }
}

# ------------------------------------------------------------

# Create a route table for managing traffic routing

resource "aws_route_table" "karv_route_table" {
  vpc_id = aws_vpc.karv_db_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.karv_igw.id
  }

  tags = {
    Name = var.route_table_name
  }
}

# ------------------------------------------------------------

# Associate the created subnets with the route table to direct their traffic

resource "aws_route_table_association" "karv_subnet_association" {
  count          = length(var.subnet_cidrs)
  subnet_id      = aws_subnet.karv_db_subnet[count.index].id
  route_table_id = aws_route_table.karv_route_table.id
}

# ------------------------------------------------------------