# asg_workers.tf
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = local.worker_name

  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  health_check_type         = var.health_check_type
  vpc_zone_identifier       = local.vpc_zone_identifier
  security_groups           = [aws_security_group.worker.id, aws_security_group.vpc_ssh.id]

  instance_refresh = {
    strategy    = local.refresh_strategy
    preferences = local.refresh_preferences
  }

  # Launch template
  launch_template_name        = local.worker_name
  launch_template_description = local.launch_template_description
  update_default_version      = local.update_default_version

  image_id          = data.aws_ami.ubuntu.id
  instance_type     = var.worker_type
  key_name          = var.key_name

  block_device_mappings = local.worker_block_device_mappings

  tags = {
    Environment = local.environment
    Name        = local.worker_name
  }
}