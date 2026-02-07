variable "role_arn" {
  description = "Lambda function accessible role arn"
  type = string
}

variable "S3_BUCKET_NAME" {
  description = "S3 bucket name"
  type = string
}

variable "ALB_DNS" {
  description = "ALB dns"
  type = string
}

variable "s3_bucket_asset_arn" {
  type = string
}

variable "s3_bucket_assets_id" {
  type = string
}