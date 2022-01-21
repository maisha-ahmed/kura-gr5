provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "terraform-remote-state-kuragrp5-2"
    key    = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}

#VPC cidr block 

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "Main VPC"
    }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "IGW"
  }
}

#Elastic IP and NAT Gateway resource for az1 
resource "aws_eip" "EIP1a" {
  vpc = true
  tags = {
    Name = "aws_eip1a" 
    }
  }

resource "aws_nat_gateway" "NAT1a" {
  allocation_id = aws_eip.EIP1a.id
  subnet_id     = aws_subnet.pub-subnet-1a.id
  tags = {
    Name = "ngw1a"
  }

  # To ensure proper ordering, it is recommended 
  # to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

#Elastic IP and NAT Gateway resource for az2
resource "aws_eip" "EIP1b" {
  vpc = true
  tags = {
    Name = "aws_eip1b" 
    }
  }

resource "aws_nat_gateway" "NAT1a" {
  allocation_id = aws_eip.EIP1b.id
  subnet_id     = aws_subnet.pub-subnet-1b.id
  tags = {
    Name = "ngw1b"
  }

  # To ensure proper ordering, it is recommended 
  # to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}


# 4 public subnets
resource "aws_subnet" "pub-subnet-1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-1a"
  }
}

resource "aws_subnet" "pub-subnet-1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-1b"
  }
}


# Database Private Subnet
resource "aws_subnet" "private-subnet-1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.21.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Database-1a"
  }
}

resource "aws_subnet" "private-subnet-1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.22.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Database-1b"
  }
}


# Create Web layber route table
# web and app are used interchangeably
resource "aws_route_table" "web-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "WebRT"
    "Terraform" = true
  }
}

# Create Web Subnet association with Web route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.pub-subnet-1a.id
  route_table_id = aws_route_table.web-rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.pub-subnet-1b.id
  route_table_id = aws_route_table.web-rt.id
}

# Private route table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NAT.id
    }
    tags = {
      "Name" = "prvt-rt-tbl"
      "Terraform" = true
    }
}

# Associate Private Route Table to 
# Private Subnet = Private-1a
resource "aws_route_table_association" "private-rta" {
  subnet_id = aws_subnet.private-subnet-1a.id
  route_table_id = aws_route_table.private-route-table.id

}

# Private Subnet = Private-1b
resource "aws_route_table_association" "private-rtb" {
  subnet_id = aws_subnet.private-subnet-1b.id
  route_table_id = aws_route_table.private-route-table.id

}

