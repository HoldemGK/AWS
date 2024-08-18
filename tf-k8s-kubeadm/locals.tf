locals {
  master_name = "${var.prefix}-master"
  worker_name = "${var.prefix}-worker"
  environment = "dev"

  vpc_zone_identifier = [var.subnet_id]

  refresh_strategy = "Rolling"
  refresh_preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
      max_healthy_percentage = 100
  }

  launch_template_description = "Launch template example"
  update_default_version      = true

  worker_block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        volume_size           = var.worker_volume_size_root
      }
    }, ]
}