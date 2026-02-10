output "db_endpoint" {
  description = "The connection host of the RDS database"
  value = aws_db_instance.db-instance.endpoint
}
output "db_address" {
  description = "The connection host of the RDS database"
  value = aws_db_instance.db-instance.address
}

output "db_port" {
  description = "The port of the RDS database"
  value = aws_db_instance.db-instance.port
}

output "db_username" {
  description = "Db username"
  value = aws_db_instance.db-instance.username
}


output "db_password" {
  value     = random_password.db_password.result
  sensitive = true
}

output "db_name" {
  description = ""
  value = aws_db_instance.db-instance.db_name
}

output "db_instance_id" {
  description = "The identifier of the RDS database instance"
  value = aws_db_instance.db-instance.id
}

output "db_security_group_id" {
  description = "The ID of the database security group"
  value       = aws_security_group.db-sg.id
}
