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
    }
}

# Associate Private Route Table to 
# Private Subnet = Private-1a
resource "aws_route_table_association" "private-rt" {
  subnet_id = aws_subnet.application-subnet-1a.id
  route_table_id = aws_route_table.private-route-table.id

}