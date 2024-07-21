resource "aws_subnet" "private-subnet" {
  count             = 3
  vpc_id            = aws_vpc.devSecOps.id
  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name        = "${var.vpc_name}-Private-Subnet-${count.index + 1}"
    Owner       = local.owner
    environment = "${var.environment}"
    projid      = local.projid
  }
}