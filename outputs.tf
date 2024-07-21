output "vpc_id" {
  description = "List of IDs of instances"
  value       = aws_vpc.devSecOps.id
}

output "public_subnet_id" {
  description = "List of availability zones of instances"
  value       = aws_subnet.public-subnet.*.id
}

output "private_subnet_id" {
  description = "List of availability zones of instances"
  value       = aws_subnet.private-subnet.*.id
}

output "public_subnet_1_id" {
  description = "List of availability zones of instances"
  value       = aws_subnet.public-subnet.0.id
}


