module "sample" {
  source = "./modules/landing_zone"
  landing_zone_components = {
      landing_zone_pipeline_s3_bucket = "s3://{BUCKET NAME}/{BUCKET KEY}/default.tfvars"
      landing_zone_pipeline_artifact_s3_bucket = "s3://{BUCKET NAME}/{BUCKET KEY}/default.tfvars"
      landing_zone_code_build_role = "s3://{BUCKET NAME}/{BUCKET KEY}/default.tfvars"
      landing_zone_code_build_role_policy = "s3://{BUCKET NAME}/{BUCKET KEY}/default.tfvars"
      landing_zone_code_build = "s3://{BUCKET NAME}/{BUCKET KEY}/default.tfvars"
      landing_zone_code_pipeline_role = "s3://{BUCKET NAME}/{BUCKET KEY}/default.tfvars"
      landing_zone_code_pipeline_role_policy = "s3://{BUCKET NAME}/{BUCKET KEY}/default.tfvars"
      landing_zone_code_pipeline = "s3://{BUCKET NAME}/{BUCKET KEY}/default.tfvars"
      landing_zone_organization = "s3://{BUCKET NAME}/{BUCKET KEY}/default.tfvars"
      landing_zone_organization_accounts = "s3://{BUCKET NAME}/{BUCKET KEY}/default.tfvars"
      landing_zone_organization_unit = "s3://{BUCKET NAME}/{BUCKET KEY}/default.tfvars"
  }
  region = "us-east-1"
  account_id = "123456789012"
}
