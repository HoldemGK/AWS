module "bastion" {
  source = "../aws-terraform-bastion"
  env_name = var.bastion_name
  vpc_id = var.ap_vpc_id
  key_pair_name = var.key_pair_name
}
