provider "aws" {
  profile = "default"
  region = "us-east-1"
}

module "vpc" {
  source = "./resources/vpc"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_1_cidr = "10.0.1.0/24"
  public_subnet_2_cidr = "10.0.3.0/24"
  private_subnet_1_cidr = "10.0.2.0/24"
  private_subnet_2_cidr = "10.0.4.0/24"
  availability_zone_1 = "us-east-1a"
  availability_zone_2 = "us-east-1b"
}

module "iam" {
  source = "./resources/iam"
}

module "rds" {
  source = "./resources/rds"
  vpc_id = module.vpc.vpc_id
  db_subnet_ids = [
    module.vpc.private_subnet_1_id,
    module.vpc.private_subnet_2_id
  ]
  security_group_ingress_ip = module.vpc.vpc_cidr

  db_identifier = "photoshare-db"
  db_engine = "mysql"
  db_engine_version = "8.4.7"
  instance_class = "db.t3.micro"
  storage_type = "gp3"
  allocated_storage = 20

  username = "admin"
  db_name = "photoshare"
}

module "secrets-manager" {
  source = "./resources/secrets-manager"
  db_username = module.rds.db_username
  db_password = module.rds.db_password
  db_host = module.rds.db_endpoint
  db_name = module.rds.db_name

  depends_on = [ module.rds ]
}

module "s3" {
  source = "./resources/s3"

  s3_bucket_name = "photoshare-assets-clb-1"
}