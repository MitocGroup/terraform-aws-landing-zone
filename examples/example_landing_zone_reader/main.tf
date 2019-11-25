module "example_landing_zone_reader" {
  source                 = "../../modules/landing_zone_reader"
  terraform_backend_type = "s3"
  terraform_backend_config = {
    bucket = "terraform-aws-landing-zone-mitocgroup"
    key    = "terraform/terrahub_load_outputs/terraform.tfstate"
    region = "us-east-1"
  }
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
