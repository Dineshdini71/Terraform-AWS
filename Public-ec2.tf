resource "aws_instance" "PUBLIC-WEB-SERVERS" {
  # count                       = 3
  count                       = var.environment == "dev" || var.environment == "DEV" ? 3 : 1
  ami                         = lookup(var.imagename, var.aws_region)
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.public-subnet.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}", "${aws_security_group.sg_dynamic.id}"]
  associate_public_ip_address = true
  tags = {
    Name        = "${var.vpc_name}-Public-Subnet-${count.index + 1}"
    Owner       = local.owner
    environment = "${var.environment}"
    projid      = local.projid
  }
  user_data = <<-EOF
		#!/bin/bash
    sudo apt-get update
		sudo apt-get install -y nginx
		sudo systemctl start nginx
		sudo systemctl enable nginx
		echo "<center><h1>Deployed via Terraform</h1><center>" | sudo tee -a /var/www/html/index.nginx-debian.html
		echo "<center><h1>"${var.vpc_name}-Public-Server-${count.index + 1}"</h1><center>" | sudo tee -a /var/www/html/index.nginx-debian.html
	EOF  
}

 