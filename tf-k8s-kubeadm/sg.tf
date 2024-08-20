# Master SG
resource "aws_security_group" "master" {
  name        = "master-ingress"
  description = "Security group for Kubernetes Master nodes"
  vpc_id      = var.vpc_id
  tags = {
    Name = "master-ingress"
  }
}

resource "aws_vpc_security_group_ingress_rule" "master_api" {
  security_group_id = aws_security_group.master.id

  cidr_ipv4   = var.vpc_cidr
  from_port   = 6443
  ip_protocol = "tcp"
  to_port     = 6443
}

resource "aws_vpc_security_group_ingress_rule" "master_etcd" {
  security_group_id = aws_security_group.master.id

  cidr_ipv4   = var.vpc_cidr
  from_port   = 2379
  ip_protocol = "tcp"
  to_port     = 2380
}

resource "aws_vpc_security_group_ingress_rule" "master_kubelet" {
  security_group_id = aws_security_group.master.id

  cidr_ipv4   = var.vpc_cidr
  from_port   = 10250
  ip_protocol = "tcp"
  to_port     = 10250
}

resource "aws_vpc_security_group_ingress_rule" "master_scheduler" {
  security_group_id = aws_security_group.master.id

  cidr_ipv4   = var.vpc_cidr
  from_port   = 10259
  ip_protocol = "tcp"
  to_port     = 10259
}

resource "aws_vpc_security_group_ingress_rule" "master_cm" {
  security_group_id = aws_security_group.master.id

  cidr_ipv4   = var.vpc_cidr
  from_port   = 10257
  ip_protocol = "tcp"
  to_port     = 10257
}

# Worker SG
resource "aws_security_group" "worker" {
  name        = "worker-ingress"
  description = "Security group for Kubernetes Worker nodes"
  vpc_id      = var.vpc_id
  tags = {
    Name = "worker-ingress"
  }
}

resource "aws_vpc_security_group_ingress_rule" "worker_kubelet" {
  security_group_id = aws_security_group.worker.id

  cidr_ipv4   = var.vpc_cidr
  from_port   = 10250
  ip_protocol = "tcp"
  to_port     = 10250
}

resource "aws_vpc_security_group_ingress_rule" "worker_kubeproxy" {
  security_group_id = aws_security_group.worker.id

  cidr_ipv4   = var.vpc_cidr
  from_port   = 10256
  ip_protocol = "tcp"
  to_port     = 10256
}

resource "aws_vpc_security_group_ingress_rule" "worker_node_ports" {
  security_group_id = aws_security_group.worker.id

  cidr_ipv4   = var.vpc_cidr
  from_port   = 30000
  ip_protocol = "tcp"
  to_port     = 32767
}