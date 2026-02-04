resource "aws_lambda_function" "this" {
  function_name = "photoshare-metadata-extractor"
  
  role = var.role_arn
  architectures = [ "x86_64" ]
  runtime = "python3.14"
}