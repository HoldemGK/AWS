variable "prefix" {
  type    = string
  default = "monitoring"
}

variable "region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "eu-north-1"
}

variable "pm_type" {
  description = "Instance type for Prometheus Server."
  type        = string
  default     = "t3.medium"
}

variable "grf_type" {
  description = "Instance type for Grafana Server"
  type        = string
  default     = "t3.micro"
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

variable "pm_volume_size_root" {
  type    = number
  default = 50
}

variable "grf_volume_size_root" {
  type    = number
  default = 30
}

variable "key_name" {
  description = "The name of the key pair to use for the instances."
  type        = string
}