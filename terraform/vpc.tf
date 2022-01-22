#Main VPC 
resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "ei-vpc"
  }
}

