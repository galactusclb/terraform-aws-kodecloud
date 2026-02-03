resource "aws_security_group" "photoshare-sg" {
  name = "photoshare-sg"
  vpc_id = var.vpc_id

  tags = {
    "Name" = "photoshare-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "photoshare-sg-ingress-http" {
  security_group_id = aws_security_group.photoshare-sg.id

  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "photoshare-sg-ingress-ssh" {
  security_group_id = aws_security_group.photoshare-sg.id

  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "photoshare-sg-egress" {
  security_group_id = aws_security_group.photoshare-sg.id

  ip_protocol = -1
  cidr_ipv4 = "0.0.0.0/0"
  description = "Allow all outbound"
}

resource "aws_lb" "photoshare-alb" {
  name = "photoshare-alb"
  load_balancer_type = "application"

  internal = false
  ip_address_type = "ipv4"

  subnets = var.public_subnets
  security_groups = [aws_security_group.photoshare-sg.id]
}

resource "aws_lb_target_group" "photoshare-alb-target-group" {
  name = "photoshare-tg"
  target_type = "instance"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
}