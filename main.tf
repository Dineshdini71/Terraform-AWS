#This Terraform Code Deploys Basic VPC Infra.
provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = "<= 3.3.14" #Forcing which version of Terraform needs to be used
  required_providers {
    aws = {
      version = "<= 6.0.0" #Forcing which version of plugin needs to be used.
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket  = "newly-terraform-tfvars"
    key     = "workspaces.tfstate"
    region  = "us-east-1"
    dynamodb_table = "workspace_terraform_locks"
    encrypt = true
  }
}

resource "aws_vpc" "workspaces" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name        = "${var.vpc_name}"
    Owner       = "Dinesh"
    environment = "${var.environment}"
  }
}

resource "aws_internet_gateway" "workspaces-igw" {
  vpc_id = aws_vpc.workspaces.id
  tags = {
    Name = "${var.IGW_name}"
  }
}

resource "aws_subnet" "subnet1-public" {
  vpc_id            = aws_vpc.workspaces.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.public_subnet1_name}"
  }
}

resource "aws_subnet" "subnet2-public" {
  vpc_id            = aws_vpc.workspaces.id
  cidr_block        = var.public_subnet2_cidr
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.public_subnet2_name}"
  }
}

resource "aws_subnet" "subnet3-public" {
  vpc_id            = aws_vpc.workspaces.id
  cidr_block        = var.public_subnet3_cidr
  availability_zone = "us-east-1c"

  tags = {
    Name = "${var.public_subnet3_name}"
  }

}


resource "aws_route_table" "terraform-public" {
  vpc_id = aws_vpc.workspaces.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.workspaces-igw.id
  }

  tags = {
    Name = "${var.Main_Routing_Table}"
  }
}

resource "aws_route_table_association" "terraform-public" {
  subnet_id      = aws_subnet.subnet1-public.id
  route_table_id = aws_route_table.terraform-public.id
}

resource "aws_security_group" "allow_all" {
  name        = "WS_allow_all"
  description = "Allow all inbound traffic-WorkSpaces"
  vpc_id      = aws_vpc.workspaces.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web-1" {
  ami                         = var.imageId
  availability_zone           = "us-east-1a"
  instance_type               = "t2.micro"
  key_name                    = "Newly"
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "${var.env}-Server-1"
    Env        = "Prod"
    Owner      = "Dini"
    CostCenter = "ABCD"
  }
  user_data = <<-EOF
    #! /bin/bash
    sudo apt-get update
    sudo apt-get install -y nginx jq
    sudo systemctl start nginx
    sudo systemctl enable apache2
    echo "<center><h1>${var.env}-Server-1</h1></center>" | sudo tee /var/www/html/index.nginx-debian.html
  EOF
}
