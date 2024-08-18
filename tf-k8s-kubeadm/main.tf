data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-24.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_subnet_ids" "default" {
  vpc_id = var.vpc_id
}

module "ec2_master" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = local.master_name

  instance_type          = var.master_type
  key_name               = var.key_name
  vpc_security_group_ids = ["sg-02357d42543ee294d"]
  subnet_id              = var.subnet_id
  ami                    = data.aws_ami.ubuntu.id

  tags = {
    Name = local.master_name
    Env  = local.environment
  }
}