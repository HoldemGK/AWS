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

variable "ami-west" {
  default = "ami-0e34e7b9ca0ace12d"
}

variable "ami-east" {
  default = "ami-09d95fab7fff3776c"
}

variable "instance_type" {
  default = "t2.micro"
}
