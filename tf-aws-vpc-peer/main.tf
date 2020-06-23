provider "aws" {
  region = var.region
}

resource "aws_vpc" "bar" {
  cidr_block = "12.0.0.0/16"

  tags = {
    Name = "bar"
  }
}

resource "aws_vpc" "foo" {
  provider   = "aws.us-west-2"
  cidr_block = "11.0.0.0/16"

  tags = {
    Name = "foo"
  }
}

resource "aws_vpc_peering_connection" "foo" {
  peer_vpc_id   = aws_vpc.bar.id
  vpc_id        = aws_vpc.foo.id
  peer_region   = var.region
}
