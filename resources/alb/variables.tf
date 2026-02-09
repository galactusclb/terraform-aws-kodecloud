variable "public_subnets" {
  description = "Public subnet Ids"
  type = list(string)
}

# variable "security_groups" {
#   description = "Security groups IDs"
#   type = list(string)
# }

variable "vpc_id" {
  description = "VPC id"
  type = string
}

variable "ec2_id" {
  description = "EC2 id to attach to target group"
  type = string
}