########################################
# VPC
########################################
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  region = var.aws_region
}

########################################
# PUBLIC SUBNET 1
########################################
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_1_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_1_name
  }
}

########################################
# PUBLIC SUBNET 2
########################################
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_2_cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_2_name
  }
}

########################################
# PRIVATE SUBNET
########################################
resource "aws_subnet" "public_3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_3_cidr
  availability_zone = "us-east-1c"

  tags = {
    Name = var.public_3_name
  }
}

########################################
# INTERNET GATEWAY
########################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name
  }
}

########################################
# PUBLIC ROUTE TABLE
########################################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.rt_name
  }
}

########################################
# ROUTE TABLE ASSOCIATIONS
########################################
resource "aws_route_table_association" "public_1_assoc" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2_assoc" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_3_assoc" {
  subnet_id      = aws_subnet.public_3.id
  route_table_id = aws_route_table.public.id
}
