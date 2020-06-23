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
