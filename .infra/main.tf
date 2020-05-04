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
    user_name  = var.tag_user_name
    department = var.tag_department
    billable   = var.tag_billable
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    user_name  = var.tag_user_name
    department = var.tag_department
    billable   = var.tag_billable
  }
}
