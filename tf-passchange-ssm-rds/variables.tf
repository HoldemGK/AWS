variable "region" {
  description = "Region for VPC"
  default = "us-east-1"
}

# random_string
variable "length" {
  description = "Password length"
  default = "12"
}

variable "special" {
  description = "Special symbols"
  default = "!#$&%"
}

variable "keeper" {
  description = "Change to reset password"
  default = "keeper"
}

# aws_ssm_parameter
variable "pass_name" {
  default = "/prod/mysql"
}

variable "pass_type" {
  default = "SecureString"
}

# aws_db_instance
variable "identifier" {
  default = "prod-rds"
}

variable "allocated_storage" {
  default = 20
}

variable "storage_type" {
  default = "gp2"
}

variable "engine" {
  description = "Database type"
  default = "mysql"
}

variable "engine_version" {
  default = "5.7"
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "rds_name" {
  default = "prod"
}

variable "username" {
  default = "administrator"
}

variable "parameter_group_name" {
  default = "default.mysql5.7"
}
