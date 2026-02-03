resource "random_password" "db_password" {
  length = 20
  special = true
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

  tags = {
    "Name" = "db-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "db-sg-ingress" {
  security_group_id = aws_security_group.db-sg.id

  from_port = 3306
  to_port = 3306
  cidr_ipv4 = var.security_group_ingress_ip
  ip_protocol = "tcp"
  description = "Allow inbound only for entire VPC"
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
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.db-sg.id]
  db_subnet_group_name = aws_db_subnet_group.photoshare-db-group.name
  skip_final_snapshot = false
}