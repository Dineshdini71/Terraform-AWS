resource "aws_vpc" "terraform_vpc_1" {
  cidr_block           = var.nv_vpc1_cidr
  enable_dns_hostnames = true
  tags = {
    Name  = var.nv_vpc1
    Owner = var.nv_owner
  }
  lifecycle {
    ignore_changes = [ tags ]
  }
}

# Internet Gatway
resource "aws_internet_gateway" "terraform_vpc_1_igw" {
  vpc_id = aws_vpc.terraform_vpc_1.id
  tags = {
    Name = "${var.nv_vpc1}-IGW"
  }
}

resource "aws_vpc" "terraform_vpc_2" {
  cidr_block           = var.nv_vpc2_cidr
  enable_dns_hostnames = true
  tags = {
    Name  = var.nv_vpc2
    Owner = var.nv_owner
  }
}

# Internet Gatway
resource "aws_internet_gateway" "terraform_vpc_2_igw" {
  vpc_id = aws_vpc.terraform_vpc_2.id
  tags = {
    Name = "${var.nv_vpc2}-IGW"
  }
}

########## Creating VPC's in OHIO region ###########

resource "aws_vpc" "ohio_devSecOps_vpc_1" {
  provider             = aws.ohio
  cidr_block           = var.ohio_vpc1_cidr
  enable_dns_hostnames = true
  tags = {
    Name  = var.ohio_vpc1
    Owner = var.ohio_owner
  }
}

resource "aws_internet_gateway" "ohio_devSecOps_vpc_1_igw" {
  provider = aws.ohio
  vpc_id   = aws_vpc.ohio_devSecOps_vpc_1.id
  tags = {
    Name = "${var.ohio_vpc1}-IGW"
  }
}


resource "aws_vpc" "ohio_devSecOps_vpc_2" {
  provider             = aws.ohio
  cidr_block           = var.ohio_vpc2_cidr
  enable_dns_hostnames = true
  tags = {
    Name  = var.ohio_vpc2
    Owner = var.ohio_owner
  }
}

resource "aws_internet_gateway" "ohio_devSecOps_vpc_2_igw" {
  provider = aws.ohio
  vpc_id   = aws_vpc.ohio_devSecOps_vpc_2.id
  tags = {
    Name = "${var.ohio_vpc2}-IGW"
  }
}



