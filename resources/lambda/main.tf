data "archive_file" "zip_function" {
  type = "zip"
  source_file = "${path.module}/functions/main.py"
  output_path = "${path.module}/functions/main.zip"
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


# cloudwatch alarm
resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  alarm_name = "PhotoShare-Lambda-Error-Alarm"

  namespace = "AWS/Lambda"
  metric_name = "Errors"
  statistic   = "Sum"
  period      = 300
  evaluation_periods = 1
  datapoints_to_alarm = 1

  threshold          = 0
  comparison_operator = "GreaterThanThreshold"

  dimensions = {
    FunctionName = aws_lambda_function.this.function_name
  }

  treat_missing_data = "notBreaching"
}