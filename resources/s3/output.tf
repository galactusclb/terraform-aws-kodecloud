output "S3_BUCKET_NAME" {
  value = aws_s3_bucket.photoshare-assets-s3-bucket.bucket
}

output "S3_BUCKET_id" {
  value = aws_s3_bucket.photoshare-assets-s3-bucket.id
}

output "S3_BUCKET_arn" {
  value = aws_s3_bucket.photoshare-assets-s3-bucket.arn
}

output "s3_bucket_dns" {
  value = aws_s3_bucket.photoshare-assets-s3-bucket.bucket_domain_name
}