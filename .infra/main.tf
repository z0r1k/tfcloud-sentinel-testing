provider "aws" {
  version = "~> 2.0"
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

resource "aws_lambda_function" "tfc_gitops_demo_lambda" {
  function_name = "tfc_demo_lambda"

  handler = "index.handler"
  runtime = "nodejs10.x"

  filename         = "../function.zip"
  source_code_hash = filebase64sha256("../function.zip")

  role = aws_iam_role.iam_for_lambda.arn

  environment {
    variables = {
      foo = "bar"
    }
  }

  tags = {
    user_name = var.tag_user_name
    department = "Teletubbies"
  }
}
