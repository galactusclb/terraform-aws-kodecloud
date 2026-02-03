output "vpc_id" {
  value       = aws_vpc.photoshare-vpc.id
  description = "The ID of the VPC"
}

output "public_subnet_1_id" {
  value       = aws_subnet.public_subnet_1.id
  description = "IDs of public subnet 1"
}

output "public_subnet_2_id" {
  value       = aws_subnet.public_subnet_2.id
  description = "IDs of public subnet 2"
}

output "private_subnet_1_id" {
  value       = aws_subnet.private_subnet_1.id
  description = "IDs of private subnet 1"
}

output "private_subnet_2_id" {
  value       = aws_subnet.private_subnet_2.id
  description = "IDs of private subnet 2"
}


output "vpc_cidr" {
  value = aws_vpc.photoshare-vpc.cidr_block
  description = "Vpc cidr"
}