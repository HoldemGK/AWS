data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = [var.ami_name]
  }
}

resource "aws_instance" "bastion" {
  name = var.env_name
  ami = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  subnet_id = data.aws_subnet.subnets.id
  key_pair_name = var.key_pair_name
  security_groups = [aws_security_group.bastion.id]
}
