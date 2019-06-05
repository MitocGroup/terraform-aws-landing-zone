output "landing_zone_pipeline_s3_bucket_id" {
  value = "${module.landing-zone.landing_zone["landing_zone_pipeline_s3_bucket_id"]}"
  description = "The name of the Landing Zone Pipeline S3 Bucket."
}

output "landing_zone_pipeline_s3_bucket_arn" {
  value = "${module.landing-zone.landing_zone["landing_zone_pipeline_s3_bucket_arn"]}"
  description = "The ARN of the Landing Zone Pipeline S3 Bucket."
}

output "landing_zone_pipeline_s3_bucket_bucket" {
  value = "${module.landing-zone.landing_zone["landing_zone_pipeline_s3_bucket_bucket"]}"
  description = "The name of the Landing Zone Pipeline S3 Bucket."
}

output "landing_zone_pipeline_artifact_s3_bucket_id" {
  value = "${module.landing-zone.landing_zone["landing_zone_pipeline_artifact_s3_bucket_id"]}"
  description = "The name of the Landing Zone Pipeline Artifact S3 Bucket."
}

output "landing_zone_pipeline_artifact_s3_bucket_arn" {
  value = "${module.landing-zone.landing_zone["landing_zone_pipeline_artifact_s3_bucket_arn"]}"
  description = "The ARN of the Landing Zone Pipeline Artifact S3 Bucket."
}

output "landing_zone_pipeline_artifact_s3_bucket_bucket" {
  value = "${module.landing-zone.landing_zone["landing_zone_pipeline_artifact_s3_bucket_bucket"]}"
  description = "The name of the Landing Zone Pipeline Artifact S3 Bucket."
}

output "landing_zone_organization_accounts_ids" {
  value = "${module.landing-zone.landing_zone["landing_zone_organization_accounts_ids"]}"
  description = "The AWS account ids"
}

output "landing_zone_organization_accounts_arns" {
  value = "${module.landing-zone.landing_zone["landing_zone_organization_accounts_arns"]}"
  description = "The ARN for this accounts"
}

output "landing_zone_organization_id" {
  value = "${module.landing-zone.landing_zone["landing_zone_organization_id"]}"
  description = "Identifier of the organization"
}

output "landing_zone_organization_accounts" {
  value = "${module.landing-zone.landing_zone["landing_zone_organization_accounts"]}"
  description = "List of organization accounts (including the master account). All elements have these attributes: arn, id, email and name"
}

output "landing_zone_organization_roots" {
  value = "${module.landing-zone.landing_zone["landing_zone_organization_roots"]}"
  description = "List of organization roots. All elements have these attributes: arn, id, name, policy_type, name and status"
}

output "landing_zone_organization_unit_id" {
  value = "${module.landing-zone.landing_zone["landing_zone_organization_unit_id"]}"
  description = "Identifier of the organization unit"
}

output "landing_zone_organization_unit_arn" {
  value = "${module.landing-zone.landing_zone["landing_zone_organization_unit_arn"]}"
  description = "ARN of the organizational unit"
}

output "landing_zone_organization_unit_accounts" {
  value = "${module.landing-zone.landing_zone["landing_zone_organization_unit_accounts"]}"
  description = "List of child accounts for this Organizational Unit. Does not return account information for child Organizational Units."
}

output "landing_zone_code_pipeline_role_id" {
  value = "${module.landing-zone.landing_zone["landing_zone_code_pipeline_role_id"]}"
  description = "The name of the role Landing Zone Code Pipeline."
}

output "landing_zone_code_pipeline_role_name" {
  value = "${module.landing-zone.landing_zone["landing_zone_code_pipeline_role_name"]}"
  description = "The name of the role Landing Zone Code Pipeline."
}

output "landing_zone_code_pipeline_id" {
  value = "${module.landing-zone.landing_zone["landing_zone_code_pipeline_id"]}"
  description = "The codepipeline ID."
}

output "landing_zone_code_pipeline_arn" {
  value = "${module.landing-zone.landing_zone["landing_zone_code_pipeline_arn"]}"
  description = "The codepipeline ARN."
}

output "landing_zone_code_build_role_id" {
  value = "${module.landing-zone.landing_zone["landing_zone_code_build_role_id"]}"
  description = "The name of the role Landing Zone Code Build."
}

output "landing_zone_code_build_role_name" {
  value = "${module.landing-zone.landing_zone["landing_zone_code_build_role_name"]}"
  description = "The name of the role Landing Zone Code Build."
}

output "landing_zone_code_build_role_arn" {
  value = "${module.landing-zone.landing_zone["landing_zone_code_build_role_arn"]}"
  description = "The ARN of the role Landing Zone Code Build."
}

output "landing_zone_code_build_id" {
  value = "${module.landing-zone.landing_zone["landing_zone_code_build_id"]}"
  description = "The name (if imported via name) or ARN (if created via Terraform or imported via ARN) of the CodeBuild project."
}

output "landing_zone_code_build_badge_url" {
  value = "${module.landing-zone.landing_zone["landing_zone_code_build_badge_url"]}"
  description = "The URL of the build badge when badge_enabled is enabled."
}

output "landing_zone_code_build_arn" {
  value = "${module.landing-zone.landing_zone["landing_zone_code_build_arn"]}"
  description = "The ARN of the CodeBuild project."
}
