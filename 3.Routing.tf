resource "aws_route_table" "terraform-public" {
  vpc_id = aws_vpc.terraform_vpc_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_vpc_1_igw.id
  }

  tags = {
    Name = "${var.nv_vpc1}-Main-RT"
  }
}


resource "aws_route_table_association" "terraform-public-1" {
  subnet_id      = aws_subnet.subnet1-public.id
  route_table_id = aws_route_table.terraform-public.id
}

resource "aws_route_table_association" "terraform-public-2" {
  subnet_id      = aws_subnet.subnet2-public.id
  route_table_id = aws_route_table.terraform-public.id
}

resource "aws_route_table_association" "terraform-public-3" {
  subnet_id      = aws_subnet.subnet3-public.id
  route_table_id = aws_route_table.terraform-public.id
}