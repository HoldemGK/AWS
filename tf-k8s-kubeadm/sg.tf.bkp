# module "bastion_sg" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "5.1.2"

#   name        = "bastion-sg"
#   description = "Security group for Bastion host"
#   vpc_id      = var.vpc_id

#   ingress_cidr_blocks = ["172.31.0.0/16"]
#   ingress_rules       = local.bastion_ingress_rules

#   egress_rules        = local.bastion_egress_rules
#   egress_cidr_blocks  = ["0.0.0.0/0"]

#   rules = local.rules
# }

# module "k8s_master_sg" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "5.1.2"

#   name        = "k8s-master-sg"
#   description = "Security group for Kubernetes Master nodes"
#   vpc_id      = var.vpc_id

#   ingress_rules = local.master_ingress_rules
#   egress_rules  = local.master_egress_rules

#   egress_cidr_blocks = ["0.0.0.0/0"]
#   rules              = local.rules
# }

module "k8s_worker_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"

  name        = "k8s-worker-sg"
  description = "Security group for Kubernetes Worker nodes"
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      cidr_blocks = ["172.31.0.0/16"]
      rule        = "all-icmp"
      cidr_blocks = ["172.31.0.0/16"]
    },
    {
      cidr_blocks = ["172.31.0.0/16"]
      rule        = "ssh-tcp"
      cidr_blocks = ["172.31.0.0/16"]
    },
    {
      cidr_blocks = ["172.31.0.0/16"]
      from_port   = 6443
      to_port     = 6443
      protocol    = "tcp"
      description = "Kubernetes API"
      
    }
  ]

  egress_rules = ["all-all"]
}
