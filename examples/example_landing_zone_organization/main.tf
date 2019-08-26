module "example_landing_zone_organization" {
  source    = "../../modules/landing_zone"
  root_path = path.module

  landing_zone_providers = {
    default = {
      account_id = "123456789012"
      region     = "us-east-1"
    }
  }

  landing_zone_backend = {
    backend = "local"
    path    = "/tmp/.terrahub/landing_zone"
  }

  landing_zone_components = {
    landing_zone_organization = "s3://terraform-aws-landing-zone/mycompany/landing_zone_organization/default.tfvars"
  }
}
