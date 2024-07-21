resource "aws_eip" "natgw_eip" {
  vpc = true
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.natgw_eip.id
  subnet_id     = aws_subnet.public-subnet.0.id

  tags = {
    Name = "${var.vpc_name}-NAT_GW"
  }
}