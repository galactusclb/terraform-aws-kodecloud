#VPC
output "vpc_id" {
  description = "ID of the VPC"
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value = module.vpc.private_subnet_ids
}

#INSTANCES

#LOAD BALANCER
output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value = module.alb.dns_name
}

# DB
output "db_address" {
  description = "RDS database address"
  value       = module.rds.db_address
}

output "db_endpoint" {
  description = "RDS database endpoint"
  value       = module.rds.db_endpoint
}

output "db_port" {
  description = "RDS database port"
  value       = module.rds.db_port
}

output "db_instance_id" {
  description = "RDS database instance ID"
  value       = module.rds.db_instance_id
}

output "db_security_group_id" {
  description = "RDS security group ID"
  value       = module.rds.db_security_group_id
}