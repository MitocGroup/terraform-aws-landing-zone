landing_zone_providers = {
  default = {
    account_id = "123456789012"
    region     = "us-east-1"
  }

  # ,
  # sample = {
  #   account_id = "123456789012"
  #   region     = "us-east-1"
  # }
}

landing_zone_components = {
  landing_zone_pipeline_s3_bucket             = "s3://terraform-aws-landing-zone/mycompany/landing_zone_pipeline_s3_bucket/config.tfvars"
  landing_zone_pipeline_artifact_s3_bucket    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_pipeline_artifact_s3_bucket/config.tfvars"
  landing_zone_code_build_role                = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_build_role/config.tfvars"
  landing_zone_code_build_role_policy         = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_build_role_policy/config.tfvars"
  landing_zone_code_build                     = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_build/config.tfvars"
  landing_zone_code_pipeline_role             = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_pipeline_role/config.tfvars"
  landing_zone_code_pipeline_role_policy      = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_pipeline_role_policy/config.tfvars"
  landing_zone_code_pipeline                  = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_pipeline/config.tfvars"
  landing_zone_organization                   = "s3://terraform-aws-landing-zone/mycompany/landing_zone_organization/config.tfvars"
  landing_zone_organization_accounts          = "s3://terraform-aws-landing-zone/mycompany/landing_zone_organization_accounts/config.tfvars"
  landing_zone_organization_unit              = "s3://terraform-aws-landing-zone/mycompany/landing_zone_organization_unit/config.tfvars"
  landing_zone_organization_policy            = "s3://terraform-aws-landing-zone/mycompany/landing_zone_organization_policy/config.tfvars"
  landing_zone_organization_policy_attachment = "s3://terraform-aws-landing-zone/mycompany/landing_zone_organization_policy_attachment/config.tfvars"
  landing_zone_vpc                            = "s3://terraform-aws-landing-zone/mycompany/landing_zone_vpc/config.tfvars"
  landing_zone_subnet                         = "s3://terraform-aws-landing-zone/mycompany/landing_zone_subnet/config.tfvars"
  landing_zone_eip                            = "s3://terraform-aws-landing-zone/mycompany/landing_zone_eip/config.tfvars"
  landing_zone_gateway_nat                    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_gateway_nat/config.tfvars"
  landing_zone_gateway_igw                    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_gateway_igw/config.tfvars"
  landing_zone_route_table                    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_route_table/config.tfvars"
  landing_zone_route_table_association        = "s3://terraform-aws-landing-zone/mycompany/landing_zone_route_table_association/config.tfvars"
  landing_zone_route                          = "s3://terraform-aws-landing-zone/mycompany/landing_zone_route/config.tfvars"
  landing_zone_route_igw                      = "s3://terraform-aws-landing-zone/mycompany/landing_zone_route_igw/config.tfvars"
  landing_zone_network_acl                    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_network_acl/config.tfvars"
  landing_zone_network_acl_rules              = "s3://terraform-aws-landing-zone/mycompany/landing_zone_network_acl_rules/config.tfvars"
  landing_zone_security_group                 = "s3://terraform-aws-landing-zone/mycompany/landing_zone_security_group/config.tfvars"
  landing_zone_security_group_rule_ingress    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_security_group_rule_ingress/config.tfvars"
  landing_zone_security_group_rule_egress     = "s3://terraform-aws-landing-zone/mycompany/landing_zone_security_group_rule_egress/config.tfvars"
  landing_zone_cloudtrail_s3_bucket           = "s3://terraform-aws-landing-zone/mycompany/landing_zone_cloudtrail_s3_bucket/config.tfvars"
  landing_zone_cloudtrail_s3_bucket_policy    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_cloudtrail_s3_bucket_policy/config.tfvars"
  landing_zone_cloudtrail                     = "s3://terraform-aws-landing-zone/mycompany/landing_zone_cloudtrail/config.tfvars"
  landing_zone_directory_service_directory    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_directory_service_directory/config.tfvars"
}
