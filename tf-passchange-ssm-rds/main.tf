provider "aws" {
  region = var.region
}

resource "random_string" "rds_password" {
  length = var.length
  special = true
  override_special = var.special
}

resource "aws_ssm_parameter" "rds_password" {
  description = "Master Password for RDS MySQL"
  name = var.pass_name
  type = var.pass_type
  value = random_string.rds_password.result
}

data "aws_ssm_parameter" "my_rds_password" {
  name = var.pass_name
  depends_on = [aws_ssm_parameter.rds_password]
}

resource "aws_db_instance" "default" {
  identifier = var.identifier
  allocated_storage = var.allocated_storage
  storage_type = var.storage_type
  engine = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  name = var.rds_name
  username = var.username
  password = data.aws_ssm_parameter.my_rds_password.value
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot = true
  apply_immediately = true
}

output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}
