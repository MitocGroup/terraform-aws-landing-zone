output "landing_zone_vpc_ids" {
  value       = lookup(module.example_landing_zone_reader.landing_zone_reader, "landing_zone_vpc_ids", "Is not set!")
  description = "The ID's of the VPC."
}

output "landing_zone_vpc_arns" {
  value       = lookup(module.example_landing_zone_reader.landing_zone_reader, "landing_zone_vpc_arns", "Is not set!")
  description = "The ARN's of the VPC."
}

output "landing_zone_subnet_ids" {
  value       = lookup(module.example_landing_zone_reader.landing_zone_reader, "landing_zone_subnet_ids", "Is not set!")
  description = "The ID's of the Subnet."
}

output "landing_zone_subnet_availability_zone_ids" {
  value       = lookup(module.example_landing_zone_reader.landing_zone_reader, "landing_zone_subnet_availability_zone_ids", "Is not set!")
  description = "The Availability Zone ID's of the Subnet."
}

output "landing_zone_subnet_arns" {
  value       = lookup(module.example_landing_zone_reader.landing_zone_reader, "landing_zone_subnet_arns", "Is not set!")
  description = "The ARN's of the Subnet."
}

output "arn" {
  value       = aws_lambda_function.hello_world.arn
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function."
}

output "qualified_arn" {
  value       = aws_lambda_function.hello_world.qualified_arn
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function Version (if versioning is enabled via publish = true)."
}

output "invoke_arn" {
  value       = aws_lambda_function.hello_world.invoke_arn
  description = "The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri"
}

output "version" {
  value       = aws_lambda_function.hello_world.version
  description = "Latest published version of your Lambda Function."
}

output "last_modified" {
  value       = aws_lambda_function.hello_world.last_modified
  description = "The date this resource was last modified."
}

output "source_code_hash" {
  value       = aws_lambda_function.hello_world.source_code_hash
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters."
}

output "source_code_size" {
  value       = aws_lambda_function.hello_world.source_code_size
  description = "The size in bytes of the function .zip file."
}
