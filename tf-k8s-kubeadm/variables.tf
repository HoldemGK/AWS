variable "prefix" {
  type    = string
  default = "k8s"
}

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

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
  default = "172.31.0.0/16"
}

variable "subnet_id" {
  type = string
}

variable "master_volume_size_root" {
  type    = number
  default = 30
}

# variable "ami_id" {
#   description = "AMI ID for the instances."
#   type        = string
#   default     = "ami-07c8c1b18ca66bb07"  # Example AMI ID; replace with your preferred AMI.
# }

variable "key_name" {
  description = "The name of the key pair to use for the instances."
  type        = string
}

# Autoscalling group Workers
variable "min_size" {
  type = number
  default = 0
}

variable "max_size" {
  type = number
  default = 5
}

variable "desired_capacity" {
  type = number
  default = 1
}

variable "wait_for_capacity_timeout" {
  type = number
  default = 0
}

variable "health_check_type" {
  type = string
  default = "EC2"
}

variable "worker_volume_size_root" {
  type    = number
  default = 50
}