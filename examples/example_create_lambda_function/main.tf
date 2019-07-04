data "terraform_remote_state" "landing_zone" {
  backend = "local"
  config = {
    path = "../../terraform.tfstate"
  }
}
resource "aws_lambda_function" "my_demo" {
  function_name = "My_Lambda_Demo"
  description = "Managed by TerraHub"
  handler = "handler.index"
  memory_size = "128"
  role = "arn:aws:iam::123456789012:role/ServiceRoleForLambdaEdge"
  runtime = "nodejs10.x"
  s3_bucket = ""
  s3_key = ""
  timeout = "30"
  vpc_config = {
    subnet_ids = ["${split(",", element(split("=", data.terraform_remote_state.landing_zone.landing_zone_subnet_ids), 1))}"]
    security_group_ids = ["${split(",", element(split("=", data.terraform_remote_state.landing_zone.landing_zone_security_group_ids), 1))}"]
  }
}
