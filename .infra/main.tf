provider "aws" {
  version = "2.33.0"
  region  = var.aws_region
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "demo_lambda" {
  function_name = "tfcloud_gitops_demo_lambda"

  handler = "index.handler"
  runtime = "nodejs12.x"

  filename         = "function.zip"
  source_code_hash = base64sha256(file("function.zip"))

  role = aws_iam_role.iam_for_lambda.arn

  environment {
    variables = {
      foo = "bar"
    }
  }

  tags = {
    user_name = var.tag_user_name
  }
}