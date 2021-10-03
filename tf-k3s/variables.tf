variable "region" {
  description = "Region for Bastion node"
  default = "ap-northeast-1"
}

variable "ap_vpc_id" {
  description = "ID of network"
  default = "vpc-31ebfb56"
}

variable "bastion_name" {
  description = "Name of EC2 Bastion"
  default = "Bastion"
}

variable "key_pair_name" {
  description = "Name of EC2 SSH key pair"
  default = "tokyo2021"
}
