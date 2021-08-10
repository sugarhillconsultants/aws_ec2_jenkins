provider "aws" {
  region  = "us-east-1"
  profile = "RomeoPeay"
}

resource "aws_instance" "ec2-instance" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2-instance-sg.id]
  key_name = aws_key_pair.Uipath.pem
  user_data = file("install_jenkins.sh")

  tags = {
    Name = "terraform-jenkins-server"
  }
}

resource "aws_security_group" "ec2-instance-sg" {
  name = "terraform-jenkins-sg"

  #ssh
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  #http
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "keypair" {
  key_name = "terraform-jenkins-server"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzHd9+N+t2I3lGrcD7jvgiymPidJCGdgC39dwlLDARR6dYsmWGWkou47sMKmnSUxNLebw8ThCW0aeP1CDANnd8H8BkCyEq1OKKEolNm+rfm026qwNWRyH4l2h16YkPA+NAfG9jLBRMWxXTZIjhCJoFE1EDUjIfriSimvpeVfaGBqQ6i5p5xeXGDyTqpuCzrlo4wWkGBKmgh79p0chJlIVx/Z5r8vZMlGQz4PnznErpA4X2iwbB6WCOL5XQBK9FhKHjPM49SDUVHajk7tHQlz04YQDrpESgydq/C7sHjzb1vi309gh1023zj1f6XdlL64ENCUcDbqynJPXTuxFDlAFUqDmPfzqLJN5ozYocSCl7FRxuHjwsdMDH/xeu0DoUhlDDISGqDzoM8Hci1HGP1UCqHTgU9VQbuLbI+tgTQzM4VU83u7BY5aWZBMT+mEjPrIY2qdFCQRWCAmo7+rqygA48qdhY6Zoec9LxKsY6Oonp0yg5A3y5o2A/TpeqxsR7tTs= pavankumar@Pavans-Air.lan"
}











