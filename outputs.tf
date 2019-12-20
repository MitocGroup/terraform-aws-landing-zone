output "landing_zone_pipeline_s3_bucket_id" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_pipeline_s3_bucket_id", "Is not set!")
  description = "The name of the Landing Zone Pipeline S3 Bucket."
}

output "landing_zone_pipeline_s3_bucket_arn" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_pipeline_s3_bucket_arn", "Is not set!")
  description = "The ARN of the Landing Zone Pipeline S3 Bucket."
}

output "landing_zone_pipeline_s3_bucket_bucket" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_pipeline_s3_bucket_bucket", "Is not set!")
  description = "The name of the Landing Zone Pipeline S3 Bucket."
}

output "landing_zone_pipeline_artifact_s3_bucket_id" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_pipeline_artifact_s3_bucket_id", "Is not set!")
  description = "The name of the Landing Zone Pipeline Artifact S3 Bucket."
}

output "landing_zone_pipeline_artifact_s3_bucket_arn" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_pipeline_artifact_s3_bucket_arn", "Is not set!")
  description = "The ARN of the Landing Zone Pipeline Artifact S3 Bucket."
}

output "landing_zone_pipeline_artifact_s3_bucket_bucket" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_pipeline_artifact_s3_bucket_bucket", "Is not set!")
  description = "The name of the Landing Zone Pipeline Artifact S3 Bucket."
}

output "landing_zone_organization_accounts_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_organization_accounts_ids", "Is not set!")
  description = "The AWS account ids"
}

output "landing_zone_organization_accounts_arns" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_organization_accounts_arns", "Is not set!")
  description = "The ARN for this accounts"
}
output "landing_zone_organization_accounts_non_master_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_organization_accounts_non_master_ids", "Is not set!")
  description = "The AWS account ids"
}

output "landing_zone_organization_accounts_non_master_arns" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_organization_accounts_non_master_arns", "Is not set!")
  description = "The ARN for this accounts"
}

output "landing_zone_organization_id" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_organization_id", "Is not set!")
  description = "Identifier of the organization"
}

output "landing_zone_organization_accounts" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_organization_accounts", "Is not set!")
  description = "List of organization accounts (including the master account). All elements have these attributes: arn, id, email and name"
}

output "landing_zone_organization_roots" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_organization_roots", "Is not set!")
  description = "List of organization roots. All elements have these attributes: arn, id, name, policy_type, name and status"
}

output "landing_zone_organization_unit_id" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_organization_unit_id", "Is not set!")
  description = "Identifier of the organization unit"
}

output "landing_zone_organization_unit_arn" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_organization_unit_arn", "Is not set!")
  description = "ARN of the organizational unit"
}

output "landing_zone_organization_unit_accounts" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_organization_unit_accounts", "Is not set!")
  description = "List of child accounts for this Organizational Unit. Does not return account information for child Organizational Units."
}

output "landing_zone_code_pipeline_role_id" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_code_pipeline_role_id", "Is not set!")
  description = "The name of the role Landing Zone Code Pipeline."
}

output "landing_zone_code_pipeline_role_name" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_code_pipeline_role_name", "Is not set!")
  description = "The name of the role Landing Zone Code Pipeline."
}

output "landing_zone_code_pipeline_id" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_code_pipeline_id", "Is not set!")
  description = "The codepipeline ID."
}

output "landing_zone_code_pipeline_arn" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_code_pipeline_arn", "Is not set!")
  description = "The codepipeline ARN."
}

output "landing_zone_code_build_role_id" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_code_build_role_id", "Is not set!")
  description = "The name of the role Landing Zone Code Build."
}

output "landing_zone_code_build_role_name" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_code_build_role_name", "Is not set!")
  description = "The name of the role Landing Zone Code Build."
}

output "landing_zone_code_build_role_arn" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_code_build_role_arn", "Is not set!")
  description = "The ARN of the role Landing Zone Code Build."
}

output "landing_zone_code_build_id" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_code_build_id", "Is not set!")
  description = "The name (if imported via name) or ARN (if created via Terraform or imported via ARN) of the CodeBuild project."
}

output "landing_zone_code_build_badge_url" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_code_build_badge_url", "Is not set!")
  description = "The URL of the build badge when badge_enabled is enabled."
}

output "landing_zone_code_build_arn" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_code_build_arn", "Is not set!")
  description = "The ARN of the CodeBuild project."
}

output "landing_zone_vpc_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_vpc_ids", "Is not set!")
  description = "The ID's of the VPC."
}

output "landing_zone_vpc_arns" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_vpc_arns", "Is not set!")
  description = "The ARN's of the VPC."
}

output "landing_zone_subnet_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_subnet_ids", "Is not set!")
  description = "The ID's of the Subnet."
}

output "landing_zone_subnet_availability_zone_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_subnet_availability_zone_ids", "Is not set!")
  description = "The Availability Zone ID's of the Subnet."
}

output "landing_zone_subnet_arns" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_subnet_arns", "Is not set!")
  description = "The ARN's of the Subnet."
}

output "landing_zone_eip_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_eip_ids", "Is not set!")
  description = "The ID's of the EIP."
}

output "landing_zone_eip_public_ips" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_eip_public_ips", "Is not set!")
  description = "The Public IP's of the EIP."
}

output "landing_zone_gateway_nat_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_gateway_nat_ids", "Is not set!")
  description = "The ID's of the Nat Gateway."
}

output "landing_zone_gateway_nat_network_interface_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_gateway_nat_network_interface_ids", "Is not set!")
  description = "The Network interface ID's of the Nat Gateway."
}

output "landing_zone_gateway_igw_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_gateway_igw_ids", "Is not set!")
  description = "The ID's of the Internet Gateway."
}

output "landing_zone_route_table_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_route_table_ids", "Is not set!")
  description = "The ID's of the Route Table."
}

output "landing_zone_route_table_association_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_route_table_association_ids", "Is not set!")
  description = "The ID's of the Route Table Association Subnets."
}

output "landing_zone_route_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_route_ids", "Is not set!")
  description = "The ID's of the Route."
}

output "landing_zone_route_igw_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_route_igw_ids", "Is not set!")
  description = "The ID's of the Local Route."
}

output "landing_zone_route_ipv6_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_route_ipv6_ids", "Is not set!")
  description = "The ID's of the Local Route."
}

output "landing_zone_route_cgw_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_route_cgw_ids", "Is not set!")
  description = "The ID's of the Local Route."
}

output "landing_zone_route_nat_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_route_nat_ids", "Is not set!")
  description = "The ID's of the Local Route."
}

output "landing_zone_route_vgw_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_route_vgw_ids", "Is not set!")
  description = "The ID's of the Local Route."
}

output "landing_zone_network_acl_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_network_acl_ids", "Is not set!")
  description = "The ID's of the Network ACL."
}

output "landing_zone_security_group_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_security_group_ids", "Is not set!")
  description = "The ID's of the Security Group."
}

output "landing_zone_cloudtrail_s3_bucket_id" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_cloudtrail_s3_bucket_id", "Is not set!")
  description = "The name of the Landing Zone CloudTrail S3 Bucket."
}

output "landing_zone_cloudtrail_s3_bucket_arn" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_cloudtrail_s3_bucket_arn", "Is not set!")
  description = "The ARN of the Landing Zone CloudTrail S3 Bucket."
}

output "landing_zone_cloudtrail_s3_bucket_bucket" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_cloudtrail_s3_bucket_bucket", "Is not set!")
  description = "The name of the Landing Zone CloudTrail S3 Bucket."
}

output "landing_zone_cloudtrail_id" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_cloudtrail_id", "Is not set!")
  description = "The name of the Landing Zone CloudTrail."
}

output "landing_zone_cloudtrail_arn" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_cloudtrail_arn", "Is not set!")
  description = "The ARN of the Landing Zone CloudTrail."
}

output "landing_zone_directory_service_directory_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_directory_service_directory_ids", "Is not set!")
  description = "The ID's of the Landing Zone Directory Service."
}

output "landing_zone_directory_service_directory_access_urls" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_directory_service_directory_access_urls", "Is not set!")
  description = "The access url's of the Landing Zone Directory Service."
}

output "landing_zone_directory_service_directory_aliases" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_directory_service_directory_aliases", "Is not set!")
  description = "The aliases of the Landing Zone Directory Service."
}

output "landing_zone_route_table_tgw_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_route_table_tgw_ids", "Is not set!")
  description = "EC2 Transit Gateway Route Table identifiers."
}

output "landing_zone_route_table_association_tgw_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_route_table_association_tgw_ids", "Is not set!")
  description = " EC2 Transit Gateway Route Table identifier combined with EC2 Transit Gateway Attachment identifiers."
}

output "landing_zone_gateway_tgw_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_gateway_tgw_ids", "Is not set!")
  description = "EC2 Transit Gateway identifiers."
}

output "landing_zone_route_pcx_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_route_pcx_ids", "Is not set!")
  description = "Identifiers of a VPC peering connection."
}

output "landing_zone_gateway_cgw_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_gateway_cgw_ids", "Is not set!")
  description = "The amazon-assigned ID's of the gateway."
}

output "landing_zone_gateway_vgw_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_gateway_vgw_ids", "Is not set!")
  description = "The ID's of the VPN Gateway."
}

output "landing_zone_iam_role_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_iam_role_ids", "Is not set!")
  description = "The name's of the role."
}

output "landing_zone_iam_role_arns" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_iam_role_arns", "Is not set!")
  description = "The Amazon Resource Name (ARN's) specifying the role."
}

output "landing_zone_iam_role_names" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_iam_role_names", "Is not set!")
  description = "The name's of the role."
}

output "landing_zone_iam_policy_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_iam_policy_ids", "Is not set!")
  description = "The role policy ID's, in the form of role_name:role_policy_name."
}

output "landing_zone_iam_policy_policies" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_iam_policy_policies", "Is not set!")
  description = "The policies document attached to the role."
}

output "landing_zone_iam_policy_names" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_iam_policy_names", "Is not set!")
  description = "The name's of the policy."
}

output "landing_zone_iam_instance_profile_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_iam_instance_profile_ids", "Is not set!")
  description = "The instance profile's ID's."
}

output "landing_zone_iam_instance_profile_arns" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_iam_instance_profile_arns", "Is not set!")
  description = "The ARN's assigned by AWS to the instance profile's."
}

output "landing_zone_iam_instance_profile_names" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_iam_instance_profile_names", "Is not set!")
  description = "The instance profile's name's."
}

output "landing_zone_iam_instance_profile_paths" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_iam_instance_profile_paths", "Is not set!")
  description = "The path's of the instance profile's in IAM."
}

output "landing_zone_iam_instance_profile_roles" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_iam_instance_profile_roles", "Is not set!")
  description = "The role's assigned to the instance profile's."
}

output "landing_zone_vpc_endpoint_gateway_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_vpc_endpoint_gateway_ids", "Is not set!")
  description = "The ID's of the VPC Endpoint Gateway."
}

output "landing_zone_vpc_endpoint_interface_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_vpc_endpoint_interface_ids", "Is not set!")
  description = "The ID's of the VPC Endpoint Interface."
}

output "landing_zone_vpc_peering_connection_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_vpc_peering_connection_ids", "Is not set!")
  description = "The ID's of the VPC Peering Connection."
}

output "landing_zone_tgw_route_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_tgw_route_ids", "Is not set!")
  description = "EC2 Transit Gateway Route Table identifiers combined with destination."
}

output "landing_zone_tgw_route_table_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_tgw_route_table_ids", "Is not set!")
  description = "EC2 Transit Gateway Route Table identifiers."
}

output "landing_zone_tgw_route_table_association_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_tgw_route_table_association_ids", "Is not set!")
  description = "EC2 Transit Gateway Route Table identifier combined with EC2 Transit Gateway Attachment identifiers."
}

output "landing_zone_tgw_route_table_propagation_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_tgw_route_table_propagation_ids", "Is not set!")
  description = "EC2 Transit Gateway Route Table identifier combined with EC2 Transit Gateway Attachment identifiers."
}

output "landing_zone_tgw_vpc_attachment_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_tgw_vpc_attachment_ids", "Is not set!")
  description = "EC2 Transit Gateway Attachment identifiers."
}

output "landing_zone_tgw_vpc_accepter_attachment_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_tgw_vpc_accepter_attachment_ids", "Is not set!")
  description = "EC2 Transit Gateway Attachment identifiers."
}

output "landing_zone_config_configuration_aggregator_arns" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_config_configuration_aggregator_arns", "Is not set!")
  description = "The ARN's of the authorization."
}

output "landing_zone_config_config_rule_arns" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_config_config_rule_arns", "Is not set!")
  description = "The ARN's of the config rule."
}

output "landing_zone_config_config_rule_rule_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_config_config_rule_rule_ids", "Is not set!")
  description = "The ID's of the config rule."
}

output "landing_zone_config_aggregate_authorization_arns" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_config_aggregate_authorization_arns", "Is not set!")
  description = "The ARN's of the aggregator."
}

output "landing_zone_config_configuration_recorder_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_config_configuration_recorder_ids", "Is not set!")
  description = "The ID's of the recorder."
}

output "landing_zone_config_delivery_channel_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_config_delivery_channel_ids", "Is not set!")
  description = "The ID's of the delivery channel."
}

output "landing_zone_config_organization_custom_rule_arns" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_config_organization_custom_rule_arns", "Is not set!")
  description = "The ARN's of the organization custom rule."
}

output "landing_zone_config_organization_managed_rule_arns" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_config_organization_managed_rule_arns", "Is not set!")
  description = "The ARN's of the organization managed rule."
}

output "landing_zone_secretsmanager_secret_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_secretsmanager_secret_ids", "Is not set!")
  description = "Amazon Resource Name (ARN's) of the secret."
}

output "landing_zone_secretsmanager_secret_arns" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_secretsmanager_secret_arns", "Is not set!")
  description = "Amazon Resource Name (ARN's) of the secret."
}

output "landing_zone_ssm_activation_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_ssm_activation_ids", "Is not set!")
  description = "The ID's of the SSM Activation."
}

output "landing_zone_ssm_association_by_instance_id_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_ssm_association_by_instance_id_ids", "Is not set!")
  description = "The ID's of the SSM Associaton by Instance ID."
}

output "landing_zone_ssm_association_by_instance_id_names" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_ssm_association_by_instance_id_names", "Is not set!")
  description = "The name of the SSM Associaton by Instance ID."
}

output "landing_zone_ssm_association_by_targets_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_ssm_association_by_targets_ids", "Is not set!")
  description = "The ID's of the SSM Associaton by targets."
}

output "landing_zone_ssm_association_by_targets_names" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_ssm_association_by_targets_names", "Is not set!")
  description = "The name of the SSM Associaton by targets."
}

output "landing_zone_ssm_document_created_dates" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_ssm_document_created_dates", "Is not set!")
  description = "The created date of the SSM Document."
}

output "landing_zone_ssm_document_hashes" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_ssm_document_hashes", "Is not set!")
  description = "The hash of the SSM Documents"
}

output "landing_zone_ssm_maintenance_window_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_ssm_maintenance_window_ids", "Is not set!")
  description = "The ID's of the SSM Maintenance Window."
}

output "landing_zone_ssm_maintenance_window_target_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_ssm_maintenance_window_target_ids", "Is not set!")
  description = "The ID's of the SSM Maintenance Window Target."

}

output "landing_zone_ssm_parameter_arns" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_ssm_parameter_arns", "Is not set!")
  description = "Amazon Resource Name (ARN's) of the SSM Parameter."
}

output "landing_zone_ssm_parameter_names" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_ssm_parameter_names", "Is not set!")
  description = "The name of the SSM Parameter."
}

output "landing_zone_ssm_patch_baseline_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_ssm_patch_baseline_ids", "Is not set!")
  description = "The ID's of the SSM Patch Baseline."
}

output "landing_zone_ssm_patch_group_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_ssm_patch_group_ids", "Is not set!")
  description = "The ID's of the SSM Patch Group."
}

output "landing_zone_sns_platform_application_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_sns_platform_application_ids", "Is not set!")
  description = "The ARN's of the SNS platform application."
}

output "landing_zone_sns_platform_application_arns" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_sns_platform_application_arns", "Is not set!")
  description = "The ARN's of the SNS platform application."
}

output "landing_zone_sns_topic_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_sns_topic_ids", "Is not set!")
  description = "The ARN's of the SNS topic."
}

output "landing_zone_sns_topic_arns" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_sns_topic_arns", "Is not set!")
  description = "The ARN's of the SNS topic."
}

output "landing_zone_sns_topic_subscription_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_sns_topic_subscription_ids", "Is not set!")
  description = "The ARN's of the subscription."
}

output "landing_zone_sns_topic_subscription_arns" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_sns_topic_subscription_arns", "Is not set!")
  description = "The ARN's of the subscription stored as a more user-friendly property."
}

output "landing_zone_sns_topic_subscription_topic_arns" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_sns_topic_subscription_topic_arns", "Is not set!")
  description = "The ARN's of the topic the subscription belongs to."
}

output "landing_zone_sns_topic_subscription_protocols" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_sns_topic_subscription_protocols", "Is not set!")
  description = "The protocol's being used."
}

output "landing_zone_sns_topic_subscription_endpoints" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_sns_topic_subscription_endpoints", "Is not set!")
  description = "The full endpoint's to send data to (SQS ARN, HTTP(S) URL, Application ARN, SMS number, etc.)."
}

output "landing_zone_guardduty_detector_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_guardduty_detector_ids", "Is not set!")
  description = "The ID's of the GuardDuty detector."
}

output "landing_zone_guardduty_detector_account_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_guardduty_detector_account_ids", "Is not set!")
  description = "The Account ID's of the GuardDuty detector."
}

output "landing_zone_guardduty_invite_accepter_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_guardduty_invite_accepter_ids", "Is not set!")
  description = "The ID's of the GuardDuty Invite Accepter."
}

output "landing_zone_guardduty_member_ids" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_guardduty_member_ids", "Is not set!")
  description = "The ID's of the GuardDuty member."
}

output "landing_zone_guardduty_member_relationship_statuses" {
  value       = lookup(module.landing_zone.landing_zone, "landing_zone_guardduty_member_relationship_statuses", "Is not set!")
  description = "The statuses of the relationship between the member account and its master account."
}
