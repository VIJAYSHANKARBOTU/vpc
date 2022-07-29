provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "demo-vpc"
    terrafomed = "true"
  }
}
resource "aws_subnet" "public-1a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.1.0/24"
   availability_zone = "ap-south-1a"
   enable_resource_name_dns_a_record_on_launch = "true"
   map_public_ip_on_launch = "true"
  tags = {
    Name = "demo-public-subnet-1a"
    terrafomed = "true"
  }
}

resource "aws_subnet" "public-1b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.2.0/24"
   availability_zone = "ap-south-1a"
   enable_resource_name_dns_a_record_on_launch = "true"
   map_public_ip_on_launch = "true"
  tags = {
    Name = "demo-public-subnet-1b"
    terrafomed = "true"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "demo-igw"
    terraformed = "true"
    created_by = "vijay"
  }
}
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "demo-rt"
  }
}
resource "aws_route_table_association" "public-asso-1" {
  subnet_id      = aws_subnet.public-1a.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "public-asso-2" {
  subnet_id      = aws_subnet.public-1b.id
  route_table_id = aws_route_table.public-rt.id
}
