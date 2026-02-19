variable "environment" {
  description = "Environment name"
  type = string
}

variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}
variable "common_tags" {
  description = "value"
  type = map(string)
}

#VPC Configuration
variable "availability_zones" {
  description = "List of availability zones to use"
  type = list(string)
  default = [ "us-east-1a", "us-east-1b" ]
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type = string
}

variable "public_subnet_cidrs" {
  description = "CIDR block for public subnets"
  type = list(string)
  default = [ "value" ]
}

variable "private_subnet_cidrs" {
  description = "CIDR block for private subnets"
  type = list(string)
  default = [ "value" ]
}


#Compute Configuration
variable "instance_type" {
  description = "EC2 instance type"
  type = string
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type = number
}

#DB Configuration
variable "db_instance_identifier" {
  description = "RDS database instance identifier"
  type = string
}

variable "db_instance_class" {
  description = "RDS database instance class"
  type = string
}

variable "db_name" {
  description = "Name of the database"
  type = string
}

variable "db_username" {
  description = "Master username for the database"
  type = string
}

variable "db_allocated_storage" {
  description = "Allocated storage size in GB"
  type = number
}

variable "db_engine" {
  description = "Database engine type"
  type = string
}

variable "db_engine_version" {
  description = "Database engine version"
  type = string
}
