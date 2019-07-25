module "example_landing_zone_s3_and_codepipeline" {
  source    = "../../modules/landing_zone"
  root_path = path.module

  landing_zone_providers = {
    default = {
      account_id = "123456789012"
      region     = "us-east-1"
    }
  }

  landing_zone_components = {
    landing_zone_pipeline_s3_bucket          = "s3://terraform-aws-landing-zone/mycompany/landing_zone_pipeline_s3_bucket/config.tfvars"
    landing_zone_pipeline_artifact_s3_bucket = "s3://terraform-aws-landing-zone/mycompany/landing_zone_pipeline_artifact_s3_bucket/config.tfvars"
    landing_zone_code_build_role             = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_build_role/config.tfvars"
    landing_zone_code_build_role_policy      = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_build_role_policy/config.tfvars"
    landing_zone_code_build                  = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_build/config.tfvars"
    landing_zone_code_pipeline_role          = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_pipeline_role/config.tfvars"
    landing_zone_code_pipeline_role_policy   = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_pipeline_role_policy/config.tfvars"
    landing_zone_code_pipeline               = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_pipeline/config.tfvars"
  }
}
