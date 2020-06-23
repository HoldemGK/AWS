resource "aws_vpc" "vpc" {
  cidr_block = "15.0.0.0/16"
  tags = {
    Name = "LAB"
  }
}

resource "aws_vpn_gateway" "aws_vpn_gateway_1" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_customer_gateway" "customer_gateway_1" {
  bgp_asn    = 65000
  ip_address = "199.126.129.250"
  type       = "ipsec.1"
}

resource "aws_vpn_connection" "main" {
  vpn_gateway_id      = aws_vpn_gateway.aws_vpn_gateway_1.id
  customer_gateway_id = aws_customer_gateway.customer_gateway_1.id
  type                = "ipsec.1"
  static_routes_only = true
  tags = {
    Name = "east_vpn_1"
  }
}
