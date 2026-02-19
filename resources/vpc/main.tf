locals {
  public_subnets = {
    for key, value in var.public_subnet_cidrs :
    key => {
      cidr_block = value,
      availability_zone = var.availability_zones[key]
    }
  }

  private_subnets = {
    for key, value in var.private_subnet_cidrs :
    key => {
      cidr_block = value,
      availability_zone = var.availability_zones[key]
    }
  }
}

resource "aws_vpc" "photoshare-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    "Name" = "photoshare-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  for_each = local.public_subnets

  vpc_id = aws_vpc.photoshare-vpc.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    "Name" = "Public Subnet ${each.key}"
  }
}

resource "aws_subnet" "private_subnet" {
  for_each = local.private_subnets

  vpc_id = aws_vpc.photoshare-vpc.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    "Name" = "Private Subnet ${each.key}"
  }
}

resource "aws_internet_gateway" "photoshare-igw" {
  vpc_id = aws_vpc.photoshare-vpc.id
  
  tags = {
    "Name" = "photoshare-igw"
  }
}

resource "aws_route_table" "photoshare-rt" {
  vpc_id = aws_vpc.photoshare-vpc.id

  route {
    gateway_id = aws_internet_gateway.photoshare-igw.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    "Name" = "photoshare-rt"
  }
}

resource "aws_route_table_association" "photoshare-rt-table-association" {
  for_each = aws_subnet.public_subnet

  route_table_id = aws_route_table.photoshare-rt.id
  subnet_id = each.value.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.photoshare-vpc.id

  tags = {
    "Name" = "photoshare-private-rt"
  }
}

resource "aws_route_table_association" "private-rt-association" {
  for_each = aws_subnet.private_subnet

  route_table_id = aws_route_table.private_rt.id
  subnet_id = each.value.id
}