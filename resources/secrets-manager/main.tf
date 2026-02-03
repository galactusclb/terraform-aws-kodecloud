resource "aws_secretsmanager_secret" "db_credentials" {
  name = "photoshare/db/credentials"
  description = "Database credentials for PhotoSharing App"
}

resource "aws_secretsmanager_secret_version" "db_credentials_value" {
  secret_id = aws_secretsmanager_secret.db_credentials.id

  secret_string = jsonencode({
    engine   = "mysql"
    port     = 3306
    username = var.db_username
    password = var.db_password
    host     = var.db_host
    dbname   = var.db_name
  })
}