data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
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

module "ec2_master" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = local.master_name
  instance_type          = var.master_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  ami                    = data.aws_ami.ubuntu.id

  root_block_device = {
        delete_on_termination = true
        volume_size           = 30
  }

  vpc_security_group_ids = ["sg-02357d42543ee294d"]

  tags = {
    Name = local.master_name
    Env  = local.environment
  }
}