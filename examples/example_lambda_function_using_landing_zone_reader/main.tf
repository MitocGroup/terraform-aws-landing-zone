module "example_landing_zone_reader" {
  source  = "../../modules/landing_zone_reader"
  version = "0.0.7"
}

resource "aws_lambda_function" "my_demo" {
  function_name = "My_Lambda_Demo"
  description   = "Managed by TerraHub"
  handler       = "handler.index"
  memory_size   = "128"
  timeout       = "30"
  role          = "arn:aws:iam::123456789012:role/ServiceRoleForLambdaEdge"
  runtime       = "nodejs10.x"
  s3_bucket     = "YOUR_S3_BUCKET_PLEASE_CHANGE"
  s3_key        = "YOUR_S3_OBJECT_PLEASE_CHANGE"

  vpc_config = {
    subnet_ids         = ["${local.landing_zone_subnet_ids["default"]}"]
    security_group_ids = ["${local.landing_zone_security_group_ids["default"]}"]
  }
}
