//create VPC
resource "aws_vpc" "alb_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
}

//create subnets
resource "aws_subnet" "private_subnet_1a" {
  vpc_id            = aws_vpc.alb_vpc.id
  cidr_block        = "10.0.101.0/24"
  availability_zone = "us-east-1a"
}
resource "aws_subnet" "private_subnet_1b" {
  vpc_id            = aws_vpc.alb_vpc.id
  cidr_block        = "10.0.102.0/24"
  availability_zone = "us-east-1b"
}

resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.alb_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id                  = aws_vpc.alb_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
}

// internet gateway for VPC
resource "aws_internet_gateway" "alb_igw" {
  vpc_id = aws_vpc.alb_vpc.id
}

//nat gateway with elastic ip
resource "aws_eip" "alb-eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "alb_nat" {
  subnet_id     = aws_subnet.public_subnet_1a.id
  allocation_id = aws_eip.alb-eip.id
  depends_on    = [aws_internet_gateway.alb_igw]
}

//create route tables
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.alb_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.alb_nat.id
  }

}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.alb_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.alb_igw.id
  }
}

//create route table association - associate subnets to route tables
resource "aws_route_table_association" "private_route_asso-1a" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_route_asso-1b" {
  subnet_id      = aws_subnet.private_subnet_1b.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "public_route_asso_1a" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public_route_asso_1b" {
  subnet_id      = aws_subnet.public_subnet_1b.id
  route_table_id = aws_route_table.public_route.id
}