module "example-create-organization" {
  source = "../../modules/landing_zone"
  landing_zone_components = {
      landing_zone_organization = "s3://{BUCKET NAME}/{BUCKET KEY}/default.tfvars"
  }
  region = "us-east-1"
  account_id = "123456789012"
}
