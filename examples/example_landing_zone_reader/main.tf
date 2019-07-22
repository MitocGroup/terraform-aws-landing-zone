module "example_landing_zone_reader" {
  source  = "../../modules/landing_zone_reader"
}

resource "aws_lambda_function" "hello_world" {
  function_name = "my_hello_world"
  description   = "Managed by TerraHub"
  runtime       = "nodejs10.x"
  handler       = "handler.index"
  memory_size   = "128"
  timeout       = "30"
  role          = "arn:aws:iam::123456789012:role/ServiceRoleForLambdaEdge"
  s3_bucket     = "www.terrahub.io"
  s3_key        = "/hello-world/nodejs10.x.zip"

  vpc_config = {
    subnet_ids         = [local.landing_zone_subnet_ids["default"]]
    security_group_ids = [local.landing_zone_security_group_ids["default"]]
  }
}
