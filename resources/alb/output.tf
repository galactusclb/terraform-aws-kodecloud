output "dns_name" {
  description = "DNS name"
  value = aws_lb.photoshare-alb.dns_name
}