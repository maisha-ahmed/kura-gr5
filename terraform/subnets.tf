resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.0.0/18"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  depends_on              = [aws_vpc.main]

  tags = {
    Name = "Public S1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.64.0/18"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true
  depends_on              = [aws_vpc.main]

  tags = {
    Name = "Public S2"
  }
}

resource "aws_subnet" "private1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.128.0/18"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = false
  depends_on              = [aws_vpc.main]

  tags = {
    Name = "Private S1"
  }
}


resource "aws_subnet" "private2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.192.0/18"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = false
  depends_on              = [aws_vpc.main]

  tags = {
    Name = "Private S2"
  }
}


#Create Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id     = aws_vpc.main.id
  depends_on = [aws_vpc.main]

  tags = {
    Name = "Internet Gateway"
  }
}


# Elastic IP for Nat Gateway
resource "aws_eip" "nat_elastic_ip" {
  vpc = true
  tags = {
    "Name" = "Elastic IP"
  }
}

#Create NAT Gateway
resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.nat_elastic_ip.id
  subnet_id     = aws_subnet.public1.id
  depends_on    = [aws_subnet.public1]

  tags = {
    "Name" = "NAT Gateway"
  }
}


#Create Public and Private Route Table
resource "aws_route_table" "routetable_public" {
  vpc_id     = aws_vpc.main.id
  depends_on = [aws_vpc.main, aws_internet_gateway.igw]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "EI RouteTable Public"
  }
}

resource "aws_route_table" "routetable_private" {
  vpc_id     = aws_vpc.main.id
  depends_on = [aws_vpc.main, aws_nat_gateway.NAT]

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT.id
  }

  tags = {
    "Name" = "EI RouteTable Private"
  }
}


#Create Route table association
resource "aws_route_table_association" "publicroute1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.routetable_public.id
  depends_on     = [aws_route_table.routetable_public]
}

resource "aws_route_table_association" "publicroute2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.routetable_public.id
  depends_on     = [aws_route_table.routetable_public]
}

resource "aws_route_table_association" "privateroute1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.routetable_private.id
  depends_on     = [aws_route_table.routetable_private]
}

resource "aws_route_table_association" "privateroute2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.routetable_private.id
  depends_on     = [aws_route_table.routetable_private]
}