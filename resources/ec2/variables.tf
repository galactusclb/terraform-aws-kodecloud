variable "vpc_id" {
  type = string
}

variable "alb_security_group_id" {
  type = string
  description = "Alb's security group id"
}

variable "subnet_id" {
  type = string
}

variable "ec2_role_id" {
  type = string
}

variable "s3_bucket" {
  type = string
}

variable "secret_name" {
  type = string
}