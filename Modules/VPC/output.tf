# -------------------------------------------------------------- #
# --------------------- VPC Module Outputs --------------------- #
# -------------------------------------------------------------- #

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "public_subnet_ids" {
  description = "Menu of Public Subnets_ID"
  value       = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  description = "Menu of  Private Subnets_ID"
  value       = aws_subnet.private_subnets[*].id
}

output "database_subnet_ids" {
  description = "Menu of  Private Subnets_ID"
  value       = aws_subnet.private_subnets[*].id
}

output "public_route_table_id" {
  description = " Public Route Table ID "
  value       = aws_route_table.public_route_table.id
}

output "private_route_table_ids" {
  description = "List of  Private Route Tables ID"
  value       = aws_route_table.private_route_table.id
}
