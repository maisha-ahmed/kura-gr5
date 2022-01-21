resource "aws_security_group" "ecs_alb_sg" {
  name        = "ecs_cluster_ALB-SG"
  description = "Allow HTTP inbound traffic for our ecs cluster"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from VPC"
    #from_port = 443 for https
    from_port   = 80
    #to_port     = 443
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-SG"
  }
}