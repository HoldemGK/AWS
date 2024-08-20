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

  # SG Rules Config
  rules = {
    "ssh"          = ["22", "22", "tcp", "SSH access"]
    "kube_api"     = ["6443", "6443", "tcp", "Kubernetes API"]
    "kubelet"      = ["10250", "10250", "tcp", "Kubelet API"]
    "nodeport"     = ["30000", "32767", "tcp", "Kubernetes NodePort"]
    "all-egress"   = ["0", "0", "-1", "Allow all egress"]
  }

  bastion_ingress_rules = ["ssh"]
  master_ingress_rules  = ["ssh", "kube_api"]
  worker_ingress_rules  = ["ssh", "kubelet", "nodeport"]

  bastion_egress_rules = ["all-egress"]
  master_egress_rules  = ["all-egress"]
  worker_egress_rules  = ["all-egress"]
}