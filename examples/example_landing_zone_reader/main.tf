module "example_landing_zone_reader" {
  source                   = "MitocGroup/landing-zone-reader/aws"
  landing_zone_providers   = var.landing_zone_providers
  landing_zone_components  = var.landing_zone_components
  terraform_backend_type   = var.terraform_backend_type
  terraform_backend_config = var.terraform_backend_config
  terraform_reader_config  = var.terraform_reader_config
}

resource "aws_lambda_function" "hello_world" {
  function_name = "my_hello_world"
  description   = "Managed by TerraHub"
  runtime       = "nodejs10.x"
  handler       = "index.handler"
  memory_size   = "128"
  timeout       = "30"
  role          = local.landing_zone_iam_role_arns["default"]["ServiceRoleForLambdaEdge"]
  s3_bucket     = "www.terrahub.io"
  s3_key        = "hello-world/nodejs10.x.zip"

  vpc_config {
    security_group_ids = values(local.landing_zone_security_group_ids["default"])
    subnet_ids         = values(local.landing_zone_subnet_ids["default"])
  }
}
