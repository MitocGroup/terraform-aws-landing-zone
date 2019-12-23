module "example_landing_zone_reader" {
  source                 = "MitocGroup/landing-zone-reader/aws"
  terraform_redeploy     = true
  terraform_backend_type = "s3"
  terraform_backend_config = {
    bucket = "terraform-aws-landing-zone-mitocgroup"
    key    = "terraform/landing_zone_reader_output/terraform.tfstate"
    region = "us-east-1"
  }
  landing_zone_providers = {
    default = {
      account_id = "123456789012"
      region     = "us-east-1"
    }
  }
  landing_zone_components = {
    landing_zone_iam_role                             = "./*.tfvars"
    landing_zone_security_group                       = "./*.tfvars"
    landing_zone_subnet                               = "./*.tfvars"
    landing_zone_vpc                                  = "./*.tfvars"
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
