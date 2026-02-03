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