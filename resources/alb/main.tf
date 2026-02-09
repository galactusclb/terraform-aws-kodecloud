resource "aws_security_group" "photoshare-sg" {
  name = "photoshare-sg"
  vpc_id = var.vpc_id

  tags = {
    "Name" = "photoshare-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.photoshare-sg.id

  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.photoshare-sg.id

  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "outbound" {
  security_group_id = aws_security_group.photoshare-sg.id

  ip_protocol = -1
  cidr_ipv4 = "0.0.0.0/0"
  description = "Allow all outbound"
}

resource "aws_lb" "this" {
  name = "photoshare-alb"
  load_balancer_type = "application"

  internal = false
  ip_address_type = "ipv4"

  subnets = var.public_subnets
  security_groups = [aws_security_group.photoshare-sg.id]
}

resource "aws_lb_target_group" "this" {
  name = "photoshare-tg"
  target_type = "instance"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
}

resource "aws_lb_target_group_attachment" "register_ec2" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id = var.ec2_id
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}