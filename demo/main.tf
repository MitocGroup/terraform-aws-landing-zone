data "terraform_remote_state" "landing_zone" {
  backend = "local"

  config = {
    path = "../terraform.tfstate"
  }
}

resource "aws_lambda_function" "my_demo" {
  function_name = "My_Lambda_Demo"
  description   = "Managed by TerraHub"
  handler       = "index.handler"
  memory_size   = "128"
  role          = "arn:aws:iam::722084099005:role/ServiceRoleForLambdaEdge"
  runtime       = "nodejs8.10"
  s3_bucket     = "www.terrahub.io"
  s3_key        = "hello-world/nodejs8.10.zip"
  timeout       = "30"

  vpc_config = {
    subnet_ids         = ["${split(",", element(split("=", data.terraform_remote_state.landing_zone.landing_zone_subnet_ids), 1))}"]
    security_group_ids = ["${split(",", element(split("=", data.terraform_remote_state.landing_zone.landing_zone_security_group_ids), 1))}"]
  }
}
