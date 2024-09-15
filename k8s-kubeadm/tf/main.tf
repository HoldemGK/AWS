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
  source = "terraform-aws-modules/ec2-instance/aws"

  name          = local.master_name
  instance_type = var.master_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  ami           = data.aws_ami.ubuntu.id
  user_data     = local.start_script_path

  root_block_device = [{
    delete_on_termination = true
    volume_size           = var.master_volume_size_root
  }]

  vpc_security_group_ids      = [aws_security_group.master.id, aws_security_group.vpc_ssh.id]
  associate_public_ip_address = false

  tags = {
    Name = local.master_name
    Env  = local.environment
  }
}