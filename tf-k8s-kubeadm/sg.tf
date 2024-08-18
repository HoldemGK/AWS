provider "aws" {
  region = "us-west-2" # Replace with your desired region
}

module "bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

  name        = "bastion-sg"
  description = "Security group for Bastion host"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["172.31.0.0/16"] # Allow SSH only from VPC_ID
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

  ingress_with_source_security_group_id = [
    {
      rule                     = "ssh"
      source_security_group_id = module.bastion_sg.this_security_group_id
    },
    {
      rule                     = "custom"
      protocol                 = "tcp"
      from_port                = 6443
      to_port                  = 6443
      description              = "Allow Kubernetes API server traffic from workers"
      source_security_group_id = module.k8s_worker_sg.this_security_group_id
    },
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

  ingress_with_source_security_group_id = [
    {
      rule                     = "ssh"
      source_security_group_id = module.bastion_sg.this_security_group_id
    },
    {
      rule                     = "custom"
      protocol                 = "tcp"
      from_port                = 10250
      to_port                  = 10250
      description              = "Allow kubelet API traffic from master"
      source_security_group_id = module.k8s_master_sg.this_security_group_id
    },
    {
      rule                     = "custom"
      protocol                 = "tcp"
      from_port                = 30000
      to_port                  = 32767
      description              = "Allow Kubernetes NodePort traffic"
      source_security_group_id = module.k8s_master_sg.this_security_group_id
    },
  ]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
}