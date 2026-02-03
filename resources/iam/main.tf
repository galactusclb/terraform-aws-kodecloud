resource "aws_iam_role" "iam_role_ec2" {
  name = "iam_role_ec2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" = "Allow"
        "Action" = "sts:AssumeRole"
        "Principal" = {
          "Service" = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role" "iam_role_lambda" {
  name = "iam_role_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" = "Allow"
        "Action" = "sts:AssumeRole"
        "Principal" = {
          "Service" = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_s3_full_access" {
  role = aws_iam_role.iam_role_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "ec2_secretsmanager_readonly" {
  role = aws_iam_role.iam_role_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AWSSecretsManagerClientReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_s3_full_access" {
  role = aws_iam_role.iam_role_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role = aws_iam_role.iam_role_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}