data "aws_vpc" "mgmt-vpc" {
  id = "vpc-0e46c4e02e94c8b52"
}

data "aws_route_table" "mgmt-vpc-route" {
  route_table_id = "rtb-0e92a1727a534401a"
}

resource "aws_vpc_peering_connection" "mgmt_vpc_peering" {
  peer_vpc_id = data.aws_vpc.mgmt-vpc.id
  vpc_id      = aws_vpc.terraform_vpc_1.id
  auto_accept = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }
  requester {
    allow_remote_vpc_dns_resolution = true
  }
  tags = {
    Name = "Terraform"
  }
}

resource "aws_vpc_peering_connection_accepter" "mgmt-vpc-peering-accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.mgmt_vpc_peering.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}

resource "aws_route" "from-terraform-to-newly" {
  route_table_id            = aws_route_table.terraform-public.id
  destination_cidr_block    = "10.164.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.mgmt_vpc_peering.id
  depends_on                = [aws_route_table.terraform-public]
}

resource "aws_route" "from-newly-to-terraform" {
  route_table_id            = data.aws_route_table.mgmt-vpc-route.id
  destination_cidr_block    = var.nv_vpc1_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.mgmt_vpc_peering.id
  depends_on                = [aws_route_table.terraform-public]
}

