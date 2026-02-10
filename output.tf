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

output "db_username" {
  description = "RDS database username"
  value       = module.rds.db_username
}


output "db_instance_id" {
  description = "RDS database instance ID"
  value       = module.rds.db_instance_id
}

output "db_security_group_id" {
  description = "RDS security group ID"
  value       = module.rds.db_security_group_id
}