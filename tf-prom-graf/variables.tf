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

variable "graf_type" {
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
