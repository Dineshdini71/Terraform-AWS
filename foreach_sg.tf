# locals {
#   ingress = distinct([22, 80, 3389, 3306])
#   egress  = distinct([80, 443])
# }

#toset - Will remove any duplicate elements and discard the ordering of the elements.
locals {
  ingress    = toset([80, 443, 444, 333, 222, 111, 111, 222, 333, 111, 222, 333])
  egress     = toset([444, 888, 777, 666, 666, 777, 888, 666, 777, 888])
  tag_keys   = distinct(["Name", "Location", "Owner", "CostCenter", "Owner", "Name", "CostCenter", "Location"])
  tag_values = distinct(["Dynamic_Sg", "USA", "DevOpsB31", "ABCD12345", "Dynamic_Sg", "USA", "DevOpsB31", "ABCD12345"])
  my_tags = {
    "Name"       = "the_dynamic_sg",
    "Location"   = "USA",
    "Owner"      = "DevSecOps",
    "CostCenter" = "ABCD12345"
  }
  #egress = var.egress
}

resource "aws_security_group" "sg_dynamic" {
  name        = "sg_dynamic"
  description = "Allow all inbound traffic using Dynamic Blocks"
  vpc_id      = aws_vpc.devSecOps.id
  dynamic "ingress" {
    for_each = local.ingress
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0", "${chomp(data.http.myip.response_body)}/32"]
    }
  }

  dynamic "egress" {
    for_each = local.egress
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0", "${chomp(data.http.myip.response_body)}/32"]
    }
  }
  #"${chomp(var.chomp)}"
  #Dynamic Block Are Not used for Tags.
  tags = {
    "Name"       = "Dynamic_Sg",
    "Location"   = "USA",
    "Owner"      = "DevOpsB32",
    "CostCenter" = "ABCD12345"
  }
}