# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "IGW"
  }
}

#Elastic IP for NAT Gateway resource
resource "aws_eip" "EIP" {
  vpc = true
  tags = {
    Name = "aws_eip" 
    }
  }

# Creating a NAT Gateway
resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.EIP.id
  subnet_id     = aws_subnet.pub-subnet-1a.id
  tags = {
    Name = "ngw"
  }

  # To ensure proper ordering, it is recommended 
  # to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

