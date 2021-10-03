data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_default_subnet" "ap_subnet" {
  availability_zone = data.aws_availability_zones.available.names[0]
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
