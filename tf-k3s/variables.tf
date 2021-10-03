variable "region" {
  description = "Region for Bastion node"
  default = "ap-northeast-1"
}

variable "ap_vpc_id" {
  description = "ID of network"
  default = "vpc-e747439d"
}

variable "bastion_name" {
  description = "Name of EC2 Bastion"
  default = "Bastion"
}
