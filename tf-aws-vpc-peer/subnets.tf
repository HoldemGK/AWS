resource "aws_subnet" "foo_sub" {
  vpc_id     = aws_vpc.foo.id
  cidr_block = "11.0.1.0/24"

  tags = {
    Name = "foo"
  }
}

resource "aws_subnet" "bar_sub" {
  vpc_id     = aws_vpc.bar.id
  cidr_block = "12.0.1.0/24"

  tags = {
    Name = "bar"
  }
}
