landing_zone_providers = {
  default = {
    account_id = "722084099005"
    region     = "us-east-1"
  }
  # ,
  # sample = {
  #   account_id = "123456789012"
  #   region     = "us-east-1"
  # }
}

landing_zone_components = {
  landing_zone_pipeline_s3_bucket             = "../mitocgroup_tfvars/landing_zone_pipeline_s3_bucket/default.tfvars"
  landing_zone_pipeline_artifact_s3_bucket    = "../mitocgroup_tfvars/landing_zone_pipeline_artifact_s3_bucket/default.tfvars"
  landing_zone_code_build_role                = "../mitocgroup_tfvars/landing_zone_code_build_role/default.tfvars"
  landing_zone_code_build_role_policy         = "../mitocgroup_tfvars/landing_zone_code_build_role_policy/default.tfvars"
  landing_zone_code_build                     = "../mitocgroup_tfvars/landing_zone_code_build/default.tfvars"
  landing_zone_code_pipeline_role             = "../mitocgroup_tfvars/landing_zone_code_pipeline_role/default.tfvars"
  landing_zone_code_pipeline_role_policy      = "../mitocgroup_tfvars/landing_zone_code_pipeline_role_policy/default.tfvars"
  landing_zone_code_pipeline                  = "../mitocgroup_tfvars/landing_zone_code_pipeline/default.tfvars"
  landing_zone_organization                   = "../mitocgroup_tfvars/landing_zone_organization/default.tfvars"
  landing_zone_organization_accounts          = "../mitocgroup_tfvars/landing_zone_organization_accounts/default.tfvars"
  landing_zone_organization_unit              = "../mitocgroup_tfvars/landing_zone_organization_unit/default.tfvars"
  landing_zone_organization_policy            = "../mitocgroup_tfvars/landing_zone_organization_policy/default.tfvars"
  landing_zone_organization_policy_attachment = "../mitocgroup_tfvars/landing_zone_organization_policy_attachment/default.tfvars"
  landing_zone_vpc                            = "../mitocgroup_tfvars/landing_zone_vpc/default.tfvars"
  landing_zone_subnet                         = "../mitocgroup_tfvars/landing_zone_subnet/default.tfvars"
  landing_zone_eip                            = "../mitocgroup_tfvars/landing_zone_eip/default.tfvars"
  landing_zone_gateway_nat                    = "../mitocgroup_tfvars/landing_zone_gateway_nat/default.tfvars"
  landing_zone_gateway_igw                    = "../mitocgroup_tfvars/landing_zone_gateway_igw/default.tfvars"
  landing_zone_route_table                    = "../mitocgroup_tfvars/landing_zone_route_table/default.tfvars"
  landing_zone_route_table_association        = "../mitocgroup_tfvars/landing_zone_route_table_association/default.tfvars"
  landing_zone_route                          = "../mitocgroup_tfvars/landing_zone_route/default.tfvars"
  landing_zone_route_igw                      = "../mitocgroup_tfvars/landing_zone_route_igw/default.tfvars"
  landing_zone_network_acl                    = "../mitocgroup_tfvars/landing_zone_network_acl/default.tfvars"
  landing_zone_network_acl_rules              = "../mitocgroup_tfvars/landing_zone_network_acl_rules/default.tfvars"
  landing_zone_security_group                 = "../mitocgroup_tfvars/landing_zone_security_group/default.tfvars"
  landing_zone_security_group_rule_ingress    = "../mitocgroup_tfvars/landing_zone_security_group_rule_ingress/default.tfvars"
  landing_zone_security_group_rule_egress     = "../mitocgroup_tfvars/landing_zone_security_group_rule_egress/default.tfvars"
  landing_zone_cloudtrail_s3_bucket           = "../mitocgroup_tfvars/landing_zone_cloudtrail_s3_bucket/default.tfvars"
  landing_zone_cloudtrail_s3_bucket_policy    = "../mitocgroup_tfvars/landing_zone_cloudtrail_s3_bucket_policy/default.tfvars"
  landing_zone_cloudtrail                     = "../mitocgroup_tfvars/landing_zone_cloudtrail/default.tfvars"
  landing_zone_directory_service_directory    = "../mitocgroup_tfvars/landing_zone_directory_service_directory/default.tfvars"
}
