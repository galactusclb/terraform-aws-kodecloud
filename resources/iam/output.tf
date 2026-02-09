output "role_ec2_id" {
  value = aws_iam_role.iam_role_ec2.id
}

output "role_ec2_arn" {
  value = aws_iam_role.iam_role_ec2.arn
}

output "role_lambda_id" {
  value = aws_iam_role.iam_role_lambda.id
}

output "role_lambda_arn" {
  value = aws_iam_role.iam_role_lambda.arn
}