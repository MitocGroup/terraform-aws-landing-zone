landing_zone_providers = {
  default = {
    account_id = "123456789012"
    region     = "us-east-1"
  }
}
landing_zone_components = {
  landing_zone_iam_role       = "./*.tfvars"
  landing_zone_security_group = "./*.tfvars"
  landing_zone_subnet         = "./*.tfvars"
  landing_zone_vpc            = "./*.tfvars"
}
terraform_backend_type = "s3"
terraform_backend_config = {
  bucket = "terraform-aws-landing-zone"
  key    = "terraform/landing_zone_reader_output/terraform.tfstate"
  region = "us-east-1"
}
terraform_reader_config = true
