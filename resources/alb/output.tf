output "dns_name" {
  description = "DNS name"
  value = aws_lb.this.dns_name
}

output "security_group_id" {
  value = aws_security_group.photoshare-sg.id
}