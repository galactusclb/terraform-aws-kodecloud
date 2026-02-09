output "ec2_sg_id" {
  value = aws_security_group.this.id
}

output "public_ip" {
  value = aws_instance.this.public_ip
  description = "The public IP address of the EC2 Instance"
}

output "ec2_id" {
  value = aws_instance.this.id
}