# Prometheus SG
resource "aws_security_group" "prometheus_server" {
  name        = "${local.prometheus_name}-ingress"
  description = "Security group for Prometheus Server"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${local.prometheus_name}-ingress"
  }
}

resource "aws_vpc_security_group_ingress_rule" "master_api" {
  security_group_id = aws_security_group.master.id

  cidr_ipv4   = var.vpc_cidr
  from_port   = 9090
  ip_protocol = "tcp"
  to_port     = 9090
}

# SSH Inside VPC
resource "aws_security_group" "vpc_ssh" {
  name        = "${local.prometheus_name}-ssh-ingress"
  description = "Security group for SSH Inside VPC"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${local.prometheus_name}-ssh-ingress"
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpc_ssh" {
  security_group_id = aws_security_group.vpc_ssh.id

  cidr_ipv4   = var.vpc_cidr
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}