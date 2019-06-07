module "example_create_organization" {
  source     = "../../modules/landing_zone"
  version    = "0.0.1"
  root_path  = "${path.module}"
  account_id = "123456789012"
  region     = "us-east-1"
  landing_zone_components = {
    landing_zone_organization = "s3://terraform-aws-landing-zone/example/landing_zone_organization/default.tfvars"
  }
}
