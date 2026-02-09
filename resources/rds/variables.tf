variable "db_identifier" {
  description = "Unique identifier for the RDS instance"
  type = string
}

variable "db_engine" {
  description = "The DB engine to be used"
  type = string
}

variable "db_engine_version" {
  description = "The DB engine version"
  type = string
}

variable "instance_class" {
  description = "The instance class to be used"
  type = string
}

variable "storage_type" {
    description = ""
    type = string
}

variable "allocated_storage" {
  description = "The storage to be allocated to the RDS instance"
  type = number
}

variable "username" {
  description = "DB username"
  type = string
  sensitive = true
}

variable "db_name" {
  description = "Initial DB name"
  type = string
}

variable "db_subnet_ids" {
  description = "The subnet ids (Private for the rds deployed)"
  type = list(string)
}

variable "security_group_ingress_id" {
  description = "Inbound security group id to allow ingress ip for rds"
  type = string
}

variable "vpc_id" {
  description = "VPC id"
  type = string
}