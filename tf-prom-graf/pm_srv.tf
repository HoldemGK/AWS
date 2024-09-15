module "prometheus_server" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name          = local.prometheus_name
  instance_type = var.pm_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  ami           = data.aws_ami.ubuntu.id
  user_data     = local.pm_script_path

  root_block_device = [{
    delete_on_termination = true
    volume_size           = var.pm_volume_size_root
  }]

  vpc_security_group_ids      = [aws_security_group.prometheus_server.id, aws_security_group.vpc_ssh.id]
  associate_public_ip_address = false

  tags = {
    Name = local.prometheus_name
    Env  = local.environment
  }
}