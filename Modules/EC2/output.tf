# -------------------------------------------------------------- #
# --------------------- VPC Module Outputs --------------------- #
# -------------------------------------------------------------- #

output "bastion_instance_ids" {
  description = "The ID of the created bastion instances"
  value       = aws_instance.bastion_instances[*].id
}

output "bastion_public_ips" {
  description = "Menu Public IPs to  Bastion Instances"
  value       = aws_instance.bastion_instances[*].public_ip
}

output "web_instance_ids" {
  description = "The ID of the created web instances"
  value       = aws_instance.web_instances[*].id
}

