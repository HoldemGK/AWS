module "bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

  name        = "bastion-sg"
  description = "Security group for Bastion host"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["172.31.0.0/16"] # Allow SSH only from your admin IP
  ingress_rules       = ["ssh"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
}

module "k8s_master_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

  name        = "k8s-master-sg"
  description = "Security group for Kubernetes Master nodes"
  vpc_id      = var.vpc_id

  ingress_rules = [
    "ssh",  # SSH access from Bastion
  ]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
}

module "k8s_worker_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

  name        = "k8s-worker-sg"
  description = "Security group for Kubernetes Worker nodes"
  vpc_id      = var.vpc_id

  ingress_rules = [
    "ssh",  # SSH access from Bastion
  ]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
}

resource "aws_security_group_rule" "master_allow_worker" {
  type                     = "ingress"
  from_port                = 6443
  to_port                  = 6443
  protocol                 = "tcp"
  security_group_id        = module.k8s_master_sg.this_security_group_id
  source_security_group_id = module.k8s_worker_sg.this_security_group_id
  description              = "Allow Kubernetes API server traffic from workers"
}

resource "aws_security_group_rule" "worker_allow_master" {
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = module.k8s_worker_sg.this_security_group_id
  source_security_group_id = module.k8s_master_sg.this_security_group_id
  description              = "Allow kubelet API traffic from master"
}

resource "aws_security_group_rule" "worker_allow_nodeport" {
  type                     = "ingress"
  from_port                = 30000
  to_port                  = 32767
  protocol                 = "tcp"
  security_group_id        = module.k8s_worker_sg.this_security_group_id
  source_security_group_id = module.k8s_master_sg.this_security_group_id
  description              = "Allow Kubernetes NodePort traffic"
}
