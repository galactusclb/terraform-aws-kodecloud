environment = "dev"
region = "us-east-1"
enable_tags=false

common_tags = {
    ManagedBy = "Terraform"
    Project = "KodeKloud"
    Environment = "dev"
}

#VPC Configuration
availability_zones = ["us-east-1a", "us-east-1b"]
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.2.0/24", "10.0.4.0/24"]

#Compute Configuration
instance_type = "t3.micro"
instance_count = 1

#DB Configuration
db_instance_identifier = "photoshare-db"
db_instance_class = "db.t3.micro"
db_name = "photoshare"
db_username = "admin"
db_allocated_storage = 20
db_engine = "mysql"
db_engine_version = "8.4.7"

#S3
s3_bucket_name="photoshare-assets-clb-1"
