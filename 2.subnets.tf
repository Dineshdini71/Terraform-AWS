resource "aws_subnet" "subnet1-public" {
  vpc_id            = aws_vpc.terraform_vpc_1.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.nv_vpc1}-Subnet-1"
  }
}

resource "aws_subnet" "subnet2-public" {
  vpc_id            = aws_vpc.terraform_vpc_1.id
  cidr_block        = var.public_subnet2_cidr
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.nv_vpc1}-Subnet-2"
  }
}

resource "aws_subnet" "subnet3-public" {
  vpc_id            = aws_vpc.terraform_vpc_1.id
  cidr_block        = var.public_subnet3_cidr
  availability_zone = "us-east-1c"

  tags = {
    Name = "${var.nv_vpc1}-Subnet-3"
  }

}


# nv Second VPC's

resource "aws_subnet" "second_subnet1-public" {
  vpc_id            = aws_vpc.terraform_vpc_2.id
  cidr_block        = var.second_public_subnet1_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.nv_vpc2}-Subnet-1"
  }
}

resource "aws_subnet" "second_subnet2-public" {
  vpc_id            = aws_vpc.terraform_vpc_2.id
  cidr_block        = var.second_public_subnet2_cidr
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.nv_vpc2}-Subnet-2"
  }
}

resource "aws_subnet" "second_subnet3-public" {
  vpc_id            = aws_vpc.terraform_vpc_2.id
  cidr_block        = var.second_public_subnet3_cidr
  availability_zone = "us-east-1c"

  tags = {
    Name = "${var.nv_vpc2}-Subnet-3"
  }

}