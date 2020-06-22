variable "instance_type" {
  description = "Instance type"
  default = "t2.micro"
}

variable "key_pair_name" {
  description = "Name of EC2 SSH key pair"
  default = "key-us-east-1"
}

variable "region" {
  description = "Region for VPC"
  default = "us-east-1"
}
