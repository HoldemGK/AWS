terraform {
  backend "s3" {
    bucket = "terraform-backend-gk"
    key    = "dev/servers/terraform.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "terraform-backend-gk"
    key    = "dev/network/terraform.tfstate"
    region = "eu-north-1"
  }
}

data "aws_ami" "latest_amazon_linux" {
  owners = ["amazon"]
  most_recent = true
  filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "web_server" {
  ami = data.aws_ami.latest_amazon_linux.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.webserver.id ]
  subnet_id = data.terraform_remote_state.network.outputs.public_subnet_ids[0]
  user_data = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform!" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF
  tags = {
    Name  = "web-server"
    Owner = "GK"
  }
}

resource "aws_security_group" "webserver" {
  name   = "WebServer Sec Group"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = [data.terraform_remote_state.network.outputs.vpc_cidr]
    description = "SSH"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags = {
    Name  = "web-server-sg"
    Owner = "GK"
  }
}

output "webserver_sg_id" {
  value = aws_security_group.webserver.id
}

output "webserver_public_ip" {
  value = aws_instance.web_server.public_ip
}