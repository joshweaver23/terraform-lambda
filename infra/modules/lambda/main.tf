data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda.js"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "this" {
  function_name = "${var.ns}-${var.name}"
  description   = var.description
  role          = var.role_arn
  timeout       = var.timeout
  tags          = var.tags
  memory_size   = var.memory
  publish       = true

  runtime = "nodejs18.x"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  vpc_config {
    subnet_ids         = var.vpc.subnet_ids
    security_group_ids = var.vpc.security_group_ids
  }

  lifecycle {
    ignore_changes = [
      environment,
    ]
  }
}

resource "aws_lambda_alias" "this" {
  name             = var.alias.name
  description      = var.alias.description
  function_name    = aws_lambda_function.this.arn
  function_version = "1"

  depends_on = [
    aws_lambda_function.this
  ]

  lifecycle {
    ignore_changes = [
      function_version,
      routing_config,
    ]
  }
}


resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${aws_lambda_function.this.function_name}"
  retention_in_days = var.log_retention

  tags = var.tags
}
