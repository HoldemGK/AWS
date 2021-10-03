data "aws_subnet_ids" "subnet_ids" {
  vpc_id = var.ap_vpc_id
}

data "aws_subnet" "subnets" {
  for_each = data.aws_subnet_ids.subnet_ids.ids
  id    = each.value
}

# Security bastion
resource "aws_security_group" "bastion" {
  name  = "Bastion Security Group"
  description = "SSH only"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = tomap({"Name" = "${var.env_name} Security Group"})
}
