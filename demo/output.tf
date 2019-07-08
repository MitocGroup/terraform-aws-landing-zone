output "id" {
  value       = "${aws_lambda_function.my_demo.id}"
  description = "The ID of the Lambda function."
}

output "arn" {
  value       = "${aws_lambda_function.my_demo.arn}"
  description = "The ARN of the Lambda function."
}
