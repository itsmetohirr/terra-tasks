output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  value = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id, aws_subnet.public_subnet_c.id]
}

output "public_subnet_cidr_block" {
  value = [aws_subnet.public_subnet_a.cidr_block, aws_subnet.public_subnet_b.cidr_block, aws_subnet.public_subnet_c.cidr_block]
}

output "public_subnet_availability_zone" {
  value = [aws_subnet.public_subnet_a.availability_zone, aws_subnet.public_subnet_b.availability_zone, aws_subnet.public_subnet_c.availability_zone]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "routing_table_id" {
  value = aws_route_table.public_rt.id
}
