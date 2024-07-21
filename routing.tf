######## PUBLIC ROUTE TABLE #########

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.devSecOps.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devSecOps-IGW.id
  }

  tags = {
    Name        = "${var.vpc_name}-Public-RT"
    Owner       = local.owner
    environment = "${var.environment}"
    projid      = local.projid
  }
}
resource "aws_route_table_association" "terraform-public" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public-subnet.*.id, count.index) #Splat Syntax
  route_table_id = aws_route_table.public-rt.id
}

######## PRIVATE ROUTE TABLE #########

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.devSecOps.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name        = "${var.vpc_name}-Private-RT"
    Owner       = local.owner
    environment = "${var.environment}"
    projid      = local.projid
  }
}

resource "aws_route_table_association" "terraform-pivate" {
  count          = length(var.private_subnet_cidr)
  subnet_id      = element(aws_subnet.private-subnet.*.id, count.index) #Splat Syntax
  route_table_id = aws_route_table.private-rt.id
}