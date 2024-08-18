module "bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

  name        = "bastion-sg"
  description = "Security group for Bastion host"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["172.31.0.0/16"]
  ingress_rules       = local.bastion_ingress_rules

  egress_rules        = local.bastion_egress_rules
  egress_cidr_blocks  = ["0.0.0.0/0"]

  rules = local.rules
}

module "k8s_master_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

  name        = "k8s-master-sg"
  description = "Security group for Kubernetes Master nodes"
  vpc_id      = var.vpc_id

  ingress_rules = local.master_ingress_rules
  egress_rules  = local.master_egress_rules

  egress_cidr_blocks = ["0.0.0.0/0"]
  rules              = local.rules
}

module "k8s_worker_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

  name        = "k8s-worker-sg"
  description = "Security group for Kubernetes Worker nodes"
  vpc_id      = var.vpc_id

  ingress_rules = local.worker_ingress_rules
  egress_rules  = local.worker_egress_rules

  egress_cidr_blocks = ["0.0.0.0/0"]
  rules              = local.rules
}
