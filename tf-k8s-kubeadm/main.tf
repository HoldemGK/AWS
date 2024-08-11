data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]  # Canonical's AWS account ID
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-24.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_subnet_ids" "default" {
  vpc_id = var.vpc_id
}

resource "aws_instance" "master" {
  count         = var.master_instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = element(data.aws_subnet_ids.default.ids, 0)
  key_name      = var.key_name

  tags = {
    Name = "Kubernetes-Master-${count.index + 1}"
    Role = "Master"
  }
}

resource "aws_instance" "worker" {
  count         = var.worker_instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = element(data.aws_subnet_ids.default.ids, count.index % length(data.aws_subnet_ids.default.ids))
  key_name      = var.key_name

  tags = {
    Name = "Kubernetes-Worker-${count.index + 1}"
    Role = "Worker"
  }
}

output "master_ips" {
  value = aws_instance.master.*.public_ip
}

output "worker_ips" {
  value = aws_instance.worker.*.public_ip
}
