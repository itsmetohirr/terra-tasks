# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "cmtr-o84gfl9h-01-vpc"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "cmtr-o84gfl9h-01-igw"
  }
}

# Create subnet
resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.10.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "cmtr-o84gfl9h-01-subnet-public-a"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.10.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "cmtr-o84gfl9h-01-subnet-public-b"
  }
}

resource "aws_subnet" "public_subnet_c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.10.5.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"

  tags = {
    Name = "cmtr-o84gfl9h-01-subnet-public-c"
  }
}

# Create Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "cmtr-o84gfl9h-01-rt"
  }
}
