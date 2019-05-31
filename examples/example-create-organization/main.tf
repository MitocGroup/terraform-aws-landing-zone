module "example-create-organization" {
  source = "../../modules/landing_zone"
  landing_zone_components = {
      landing_zone_organization = "s3://terraform-aws-landing-zone/example/landing_zone_organization/default.tfvars"
  }
  region = "us-east-1"
  account_id = "123456789012"
}
