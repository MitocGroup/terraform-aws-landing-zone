landing_zone_providers = {
  default = {
    account_id = "123456789012"
    region     = "us-east-1"
  }
#  ,sample = {
#    account_id = "987654321098"
#    region     = "us-east-1"
#  }
}

landing_zone_backend = {
  backend = "local"
  path    = "/tmp/.terrahub/landing_zone"
}

landing_zone_components = {
  landing_zone_pipeline_s3_bucket             = "s3://terraform-aws-landing-zone/mycompany/landing_zone_pipeline_s3_bucket/default.tfvars"
  landing_zone_pipeline_artifact_s3_bucket    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_pipeline_artifact_s3_bucket/default.tfvars"
  landing_zone_code_build                     = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_build/default.tfvars"
  landing_zone_code_build_role                = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_build_role/default.tfvars"
  landing_zone_code_build_role_policy         = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_build_role_policy/default.tfvars"
  landing_zone_code_pipeline                  = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_pipeline/default.tfvars"
  landing_zone_code_pipeline_role             = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_pipeline_role/default.tfvars"
  landing_zone_code_pipeline_role_policy      = "s3://terraform-aws-landing-zone/mycompany/landing_zone_code_pipeline_role_policy/default.tfvars"
  landing_zone_organization                   = "s3://terraform-aws-landing-zone/mycompany/landing_zone_organization/default.tfvars"
  landing_zone_organization_accounts          = "s3://terraform-aws-landing-zone/mycompany/landing_zone_organization_accounts/default.tfvars"
  landing_zone_organization_unit              = "s3://terraform-aws-landing-zone/mycompany/landing_zone_organization_unit/default.tfvars"
  landing_zone_organization_policy            = "s3://terraform-aws-landing-zone/mycompany/landing_zone_organization_policy/default.tfvars"
  landing_zone_organization_policy_attachment = "s3://terraform-aws-landing-zone/mycompany/landing_zone_organization_policy_attachment/default.tfvars"
  landing_zone_vpc                            = "s3://terraform-aws-landing-zone/mycompany/landing_zone_vpc/default.tfvars"
  landing_zone_subnet                         = "s3://terraform-aws-landing-zone/mycompany/landing_zone_subnet/default.tfvars"
  landing_zone_eip                            = "s3://terraform-aws-landing-zone/mycompany/landing_zone_eip/default.tfvars"
  landing_zone_gateway_attachment_tgw         = "s3://terraform-aws-landing-zone/mycompany/landing_zone_gateway_attachment_tgw/default.tfvars"
  landing_zone_gateway_cgw                    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_gateway_cgw/default.tfvars"
  landing_zone_gateway_nat                    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_gateway_nat/default.tfvars"
  landing_zone_gateway_igw                    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_gateway_igw/default.tfvars"
  landing_zone_gateway_tgw                    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_gateway_tgw/default.tfvars"
  landing_zone_gateway_vgw                    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_gateway_vgw/default.tfvars"
  landing_zone_route_table                    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_route_table/default.tfvars"
  landing_zone_route_table_association        = "s3://terraform-aws-landing-zone/mycompany/landing_zone_route_table_association/default.tfvars"
  landing_zone_route_table_association_tgw    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_route_table_association_tgw/default.tfvars"
  landing_zone_route_table_tgw                = "s3://terraform-aws-landing-zone/mycompany/landing_zone_route_table_tgw/default.tfvars"
  landing_zone_route_tgw                      = "s3://terraform-aws-landing-zone/mycompany/landing_zone_route_tgw/default.tfvars"
  landing_zone_route                          = "s3://terraform-aws-landing-zone/mycompany/landing_zone_route/default.tfvars"
  landing_zone_route_igw                      = "s3://terraform-aws-landing-zone/mycompany/landing_zone_route_igw/default.tfvars"
  landing_zone_network_acl                    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_network_acl/default.tfvars"
  landing_zone_network_acl_rules              = "s3://terraform-aws-landing-zone/mycompany/landing_zone_network_acl_rules/default.tfvars"
  landing_zone_security_group                 = "s3://terraform-aws-landing-zone/mycompany/landing_zone_security_group/default.tfvars"
  landing_zone_security_group_rule_ingress    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_security_group_rule_ingress/default.tfvars"
  landing_zone_security_group_rule_egress     = "s3://terraform-aws-landing-zone/mycompany/landing_zone_security_group_rule_egress/default.tfvars"
  landing_zone_cloudtrail_s3_bucket           = "s3://terraform-aws-landing-zone/mycompany/landing_zone_cloudtrail_s3_bucket/default.tfvars"
  landing_zone_cloudtrail_s3_bucket_policy    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_cloudtrail_s3_bucket_policy/default.tfvars"
  landing_zone_cloudtrail                     = "s3://terraform-aws-landing-zone/mycompany/landing_zone_cloudtrail/default.tfvars"
  landing_zone_directory_service_directory    = "s3://terraform-aws-landing-zone/mycompany/landing_zone_directory_service_directory/default.tfvars"
}
