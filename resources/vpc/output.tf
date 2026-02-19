output "vpc_id" {
  value       = aws_vpc.photoshare-vpc.id
  description = "The ID of the VPC"
}

output "vpc_cidr" {
  value = aws_vpc.photoshare-vpc.cidr_block
  description = "Vpc cidr"
}

output "public_subnet_ids" {
  value       =  values(aws_subnet.public_subnet)[*].id
  description = "List of IDs of the public subnets"
}
 
output "private_subnet_ids" {
  value       = values(aws_subnet.private_subnet)[*].id
  description = "List of IDs of the private subnets"
}