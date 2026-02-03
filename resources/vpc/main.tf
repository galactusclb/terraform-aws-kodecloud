resource "aws_vpc" "photoshare-vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    "Name" = "photoshare-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.photoshare-vpc.id
  cidr_block = var.public_subnet_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    "Name" = "Public Subnet 1"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.photoshare-vpc.id
  cidr_block = var.private_subnet_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    "Name" = "Private Subnet 1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.photoshare-vpc.id
  cidr_block = var.public_subnet_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    "Name" = "Public Subnet 2"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = aws_vpc.photoshare-vpc.id
  cidr_block = var.private_subnet_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    "Name" = "Private Subnet 2"
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

resource "aws_route_table_association" "photoshare-rt-table-association-1" {
  route_table_id = aws_route_table.photoshare-rt.id
  subnet_id = aws_subnet.public_subnet_1.id
}

resource "aws_route_table_association" "photoshare-rt-table-association-2" {
  route_table_id = aws_route_table.photoshare-rt.id
  subnet_id = aws_subnet.public_subnet_2.id
}
