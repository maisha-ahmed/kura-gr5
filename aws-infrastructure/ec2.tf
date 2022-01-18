#Create EC2 Instance
resource "aws_instance" "appserver1" {
  ami                    = "ami-0d5eff06f840b45e9"
  instance_type          = "t2.micro"
  key_name               = "ClassKeyJenkins"
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  subnet_id              = aws_subnet.application-subnet-1a.id
  
  user_data = <<-EOL
  #!/bin/bash
  sudo apt-get update
  sudo apt-get upgrade
  sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    Software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  apt-cache madison docker-ce
  sudo apt install docker.io
  sudo apt install docker-compose
  sudo usermod -a -G docker ubuntu
  EOL
  
  tags = {
    Name = "App Server 1a"
  }

}

resource "aws_instance" "appserver2" {
  ami                    = "ami-0d5eff06f840b45e9"
  instance_type          = "t2.micro"
  key_name               = "ClassKeyJenkins"
  availability_zone      = "us-east-1b"
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  subnet_id              = aws_subnet.application-subnet-1b.id
  #user_data              = file("install_docker.sh")

  tags = {
    Name = "App Server 1b"
  }

}