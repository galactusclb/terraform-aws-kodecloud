data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_security_group" "this" {
  vpc_id = var.vpc_id
  name = "photoshare-web-sg"
  description = "Security group for Web Server"

  tags = {
    "Name" = "photoshare-web-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.this.id

  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
  referenced_security_group_id = var.alb_security_group_id

  tags = {
    "Name" = "Allow_web"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.this.id

  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_iam_instance_profile" "ec2_role_profile" {
  name = "ec2_role_profile"
  role = var.ec2_role_id
}

resource "aws_instance" "this" {
 
 instance_type = "t3.micro"
 ami = data.aws_ssm_parameter.al2023.id
 subnet_id = var.subnet_id
 vpc_security_group_ids = [ aws_security_group.this.id ]
 associate_public_ip_address = true
 iam_instance_profile = aws_iam_instance_profile.ec2_role_profile.id


  user_data = templatefile("${path.module}/source/install.sh", {
    s3_bucket = var.s3_bucket
  })

  tags = {
    "Name" = "photoshare-web"
  }
}