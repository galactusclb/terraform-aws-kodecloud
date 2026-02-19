provider "aws" {
  profile = "default"
  region  = var.region

  default_tags {
    tags = merge(
      var.common_tags,
      {
        Environment = var.environment
      }
    )
  }
}

module "vpc" {
  source                = "./resources/vpc"
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "iam" {
  source = "./resources/iam"
}

module "rds" {
  source = "./resources/rds"
  vpc_id = module.vpc.vpc_id
  db_subnet_ids = module.vpc.private_subnet_ids
  security_group_ingress_id = module.ec2.ec2_sg_id

  db_identifier     = var.db_instance_identifier
  db_engine         = var.db_engine
  db_engine_version = var.db_engine_version
  instance_class    = var.db_instance_class
  storage_type      = "gp3"
  allocated_storage = var.db_allocated_storage

  username = var.db_username
  db_name  = var.db_name
  db_port  = 3306
}

module "secrets-manager" {
  source      = "./resources/secrets-manager"
  db_username = module.rds.db_username
  db_password = module.rds.db_password
  db_host     = module.rds.db_address
  db_name     = module.rds.db_name

  depends_on = [module.rds]
}

module "s3" {
  source = "./resources/s3"

  s3_bucket_name = var.s3_bucket_name
}

module "alb" {
  source = "./resources/alb"

  vpc_id = module.vpc.vpc_id
  ec2_id = module.ec2.ec2_id

  public_subnets = module.vpc.public_subnet_ids
}

module "lambda" {
  source = "./resources/lambda"

  S3_BUCKET_NAME      = module.s3.S3_BUCKET_NAME
  ALB_DNS             = module.alb.dns_name
  s3_bucket_assets_id = module.s3.S3_BUCKET_id
  s3_bucket_asset_arn = module.s3.S3_BUCKET_arn
  role_arn            = module.iam.role_lambda_arn
}

module "ec2" {
  source = "./resources/ec2"

  vpc_id                = module.vpc.vpc_id
  alb_security_group_id = module.alb.security_group_id
  subnet_id             = module.vpc.public_subnet_ids[1]
  ec2_role_id           = module.iam.role_ec2_id
  s3_bucket             = module.s3.S3_BUCKET_NAME
  secret_name           = module.secrets-manager.secret_name
}

module "cloudwatch" {
  source = "./resources/cloudwatch"

  region = var.region
  instance_id           = module.ec2.ec2_id
  lambda_functiona_name = module.lambda.lambda_function_name
}