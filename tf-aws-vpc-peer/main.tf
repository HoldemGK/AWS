provider "aws" {
  region = var.region
}

resource "aws_vpc_peering_connection" "foo" {
  peer_vpc_id   = aws_vpc.bar.id
  vpc_id        = aws_vpc.foo.id
  peer_region   = var.region
}

resource "aws_vpc" "foo" {
  provider   = "aws.us-west-2"
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "foo"
  }
}

resource "aws_vpc" "bar" {
  provider   = "aws.us-east-1"
  cidr_block = "10.2.0.0/16"

  tags = {
    Name = "bar"
  }
}
