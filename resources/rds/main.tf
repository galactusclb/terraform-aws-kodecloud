resource "random_password" "db_password" {
  length            = 20
  special           = false
}

resource "aws_db_subnet_group" "photoshare-db-group" {
  name = "photoshare-db-group"
  description = "DB Subnet Group for PhotoShare"

  subnet_ids = var.db_subnet_ids

  tags = {
    "Name" = "photoshare-db-group"
  }
}

resource "aws_security_group" "db-sg" {
  vpc_id = var.vpc_id
  description = "Security group for PhotoShare RDS database"
  name = "db-sg"

  tags = {
    "Name" = "db-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "db-sg-ingress" {
  security_group_id = aws_security_group.db-sg.id

  from_port = var.db_port
  to_port = var.db_port
  referenced_security_group_id = var.security_group_ingress_id
  ip_protocol = "tcp"
  description = "Allow inbound only from EC2"
}

resource "aws_vpc_security_group_egress_rule" "db-sg-egress" {
  security_group_id = aws_security_group.db-sg.id

  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
  description = "Allow all outbound"
}

resource "aws_db_instance" "db-instance" {
  identifier = var.db_identifier
  engine = var.db_engine
  engine_version = var.db_engine_version
  instance_class = var.instance_class
  storage_type = var.storage_type
  allocated_storage = var.allocated_storage

  username = var.username
  password = random_password.db_password.result
  db_name = var.db_name
  port = var.db_port

  publicly_accessible = false
  backup_retention_period = 0

  vpc_security_group_ids = [aws_security_group.db-sg.id]
  db_subnet_group_name = aws_db_subnet_group.photoshare-db-group.name

  skip_final_snapshot = true
  apply_immediately = true
}