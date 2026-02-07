data "archive_file" "zip_function" {
  type = "zip"
  source_dir = "${path.module}/functions/main.py"
  output_path = "${path.module}/functions"
}

resource "aws_lambda_function" "this" {
  function_name = "photoshare-metadata-extractor"
  filename = data.archive_file.zip_function.output_path
  handler = "main.lambda_handler"

  role = var.role_arn
  architectures = [ "x86_64" ]
  runtime = "python3.14"

  environment {
    variables = {
      "S3_BUCKET" = var.S3_BUCKET_NAME
      "ALB_DNS" = var.ALB_DNS
    }
  }
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id = "AllowExecutionFromS3"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal = "s3.amazonaws.com"
  source_arn = var.s3_bucket_asset_arn
}

resource "aws_s3_bucket_notification" "upload_notification" {
  bucket = var.s3_bucket_assets_id

  lambda_function {
    lambda_function_arn = aws_lambda_function.this.arn
    events = ["s3:ObjectCreated:*"]
  }

  depends_on = [ aws_lambda_permission.allow_s3 ]
}