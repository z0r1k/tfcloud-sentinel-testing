output "tfc_demo_lambda_arn" {
  value = aws_lambda_function.tfc_gitops_demo_lambda.arn
}

output "tfc_demo_lambda_invoke_arn" {
  value = aws_lambda_function.tfc_gitops_demo_lambda.invoke_arn
}
