variable "region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "eu-north-1"
}

variable "master_type" {
  description = "Instance type for master."
  type        = string
  default     = "t3.medium"
}

variable "worker_type" {
  description = "Instance type for the Kubernetes nodes."
  type        = string
  default     = "t3.micro"
}

variable "master_instance_count" {
  description = "Number of master nodes."
  type        = number
  default     = 1
}

variable "worker_instance_count" {
  description = "Number of worker nodes."
  type        = number
  default     = 1
}

variable "ami_id" {
  description = "AMI ID for the instances."
  type        = string
  default     = "ami-07c8c1b18ca66bb07"  # Example AMI ID; replace with your preferred AMI.
}

variable "vpc_id" {
  description = "VPC ID where instances will be launched."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where instances will be launched."
  type        = string
}

variable "key_name" {
  description = "The name of the key pair to use for the instances."
  type        = string
}
