data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = [var.ami_name]
  }
}

resource "aws_instance" "bastion" {
  ami = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  subnet_id = aws_default_subnet.ap_subnet.id
  security_groups = [aws_security_group.bastion.id]
}
