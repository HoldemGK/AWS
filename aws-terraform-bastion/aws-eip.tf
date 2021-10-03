resource "aws_eip" "bastion" {
  vpc  = true
  tags = merge(tomap({"Name" = "${var.env_name} EIP"}),
    var.tags_all)
}
