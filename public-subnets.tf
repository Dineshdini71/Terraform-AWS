resource "aws_subnet" "public-subnet" {
  count             = 3
  vpc_id            = aws_vpc.devSecOps.id
  cidr_block        = element(var.public_subnet_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name        = "${var.vpc_name}-Public-Subnet-${count.index + 1}"
    Owner       = local.owner
    environment = "${var.environment}"
    projid      = local.projid
  }
}

