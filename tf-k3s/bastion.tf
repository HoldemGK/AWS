provider "aws" {
  region = var.region
}

module "bastion" {
  source = "../aws-terraform-bastion"
  env_name = var.bastion_name
  vpc_id = var.ap_vpc_id
}
