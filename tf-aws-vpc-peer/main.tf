provider "aws" {
  region = var.region
}

resource "aws_vpc" "foo" {
  region = var.region_west
  cidr_block = "11.0.0.0/16"

  tags = {
    Name = "foo"
  }
}

resource "aws_subnet" "foo_sub" {
  vpc_id     = aws_vpc.foo.id
  cidr_block = "11.0.1.0/24"

  tags = {
    Name = "foo"
  }
}

resource "aws_vpc" "bar" {
  region = var.region
  cidr_block = "12.0.0.0/16"

  tags = {
    Name = "bar"
  }
}

resource "aws_subnet" "bar_sub" {
  vpc_id     = aws_vpc.bar.id
  cidr_block = "12.0.1.0/24"

  tags = {
    Name = "bar"
  }
}

resource "aws_vpc_peering_connection" "foo" {
  peer_vpc_id   = aws_vpc.bar.id
  vpc_id        = aws_vpc.foo.id
  peer_region   = var.region
}

resource "aws_instance" "foo_inst" {
  ami = var.ami-west
  instance_type = var.instance_type
  subnet_id = aws_subnet.foo_sub.id
}

resource "aws_instance" "bar_inst" {
  ami = var.ami-east
  instance_type = var.instance_type
  subnet_id = aws_subnet.bar_sub.id
}
