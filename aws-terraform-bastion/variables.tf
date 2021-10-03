variable "instance_type" {
  description = "Instance type"
  default = "t2.micro"
}

variable "key_pair_name" {
  description = "Name of EC2 SSH key pair"
  default = "bastion"
}

variable "region" {
  description = "Region for Bastion node"
  default = "us-east-1"
}

variable "vpc_id" {
  description = "ID of network"
  default = "vpc-e747439d"
}

variable "env_name" {
  description = "Name of EC2 instance"
  default = "Bastion"
}

variable "image_id" {
  description = "ID of image AMI"
  default = "ami-010fae13a16763bb4"
}

variable "tags_ec2" {
  description = "List of maps of tags that will be applied to the Auto Scaling group for Bastion node"
  default = [
    {
      "key"                 = "Application",
      "value"               = "AWS DevOps Challenge",
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Terraformed",
      "value"               = "true",
      "propagate_at_launch" = true
    }
  ]
}

variable "tags_all" {
  description = "Map of specific tags that will be added to the defaults"
  default = {
    Application = "AWS DevOps Challenge"
    Terraformed = "true"
  }
}
