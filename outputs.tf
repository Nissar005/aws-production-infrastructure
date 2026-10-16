# Expose useful networking details after Terraform creates the infrastructure.
output "vpc_id" {
  description = "ID of the project VPC"
  value       = module.networking.vpc_id
}

# Public subnet IDs are intended for internet-facing resources such as a load balancer.
output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.networking.public_subnet_ids
}

# Private subnet IDs are intended for application workloads that should not receive public IPs.
output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.networking.private_subnet_ids
}
