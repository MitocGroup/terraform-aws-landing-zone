#!/usr/bin/env bash

LOCAL_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../components/" >/dev/null 2>&1 && pwd )"

#############################
# landing_zone_organization #
#############################
terrahub import --batch ${LOCAL_PATH}/landing_zone_organization/default.tfimport \
  --include landing_zone_organization

######################################
# landing_zone_organization_accounts #
######################################
terrahub import --batch ${LOCAL_PATH}/landing_zone_organization_accounts/default.tfimport \
  --include landing_zone_organization_accounts

############################################
# landing_zone_directory_service_directory #
############################################
terrahub import --batch ${LOCAL_PATH}/landing_zone_directory_service_directory/default.tfimport \
  --include landing_zone_directory_service_directory

###########################
# landing_zone_cloudtrail # @todo
###########################
#terrahub import --batch ${LOCAL_PATH}/landing_zone_cloudtrail/default.tfimport \
#  --include landing_zone_cloudtrail_s3_bucket,landing_zone_cloudtrail_s3_bucket_policy,landing_zone_cloudtrail,landing_zone_directory_service_directory

###########################
# landing_zone_vpc_subnet #
###########################
terrahub import --batch ${LOCAL_PATH}/landing_zone_vpc_subnet/default.tfimport \
  --include landing_zone_gateway_igw,landing_zone_gateway_nat,landing_zone_network_acl,landing_zone_route,landing_zone_route_igw,landing_zone_route_ipv6,landing_zone_route_pcx,landing_zone_route_table,landing_zone_route_table_association,landing_zone_subnet,landing_zone_vpc,landing_zone_vpc_endpoint_gateway,landing_zone_vpc_endpoint_interface,landing_zone_vpc_peering_connection

###############################
# landing_zone_security_group #
###############################
terrahub import --batch ${LOCAL_PATH}/landing_zone_security_group/default.tfimport \
  --include landing_zone_security_group,landing_zone_security_group_rule_egress,landing_zone_security_group_rule_ingress

#########################
# landing_zone_iam_role #
#########################
terrahub import --batch ${LOCAL_PATH}/landing_zone_iam_role/default.tfimport \
  --include landing_zone_iam_role

###########################
# landing_zone_iam_policy #
###########################
terrahub import --batch ${LOCAL_PATH}/landing_zone_iam_policy/default.tfimport \
  --include landing_zone_iam_policy

###########################################
# landing_zone_iam_role_policy_attachment #
###########################################
terrahub import --batch ${LOCAL_PATH}/landing_zone_iam_role_policy_attachment/default.tfimport \
  --include landing_zone_iam_role_policy_attachment
terrahub import --batch ${LOCAL_PATH}/landing_zone_iam_role_policy_attachment/bloomingaprons.tfimport \
  --include landing_zone_iam_role_policy_attachment
terrahub import --batch ${LOCAL_PATH}/landing_zone_iam_role_policy_attachment/mitocgroup.tfimport \
  --include landing_zone_iam_role_policy_attachment
terrahub import --batch ${LOCAL_PATH}/landing_zone_iam_role_policy_attachment/terrahub.tfimport \
  --include landing_zone_iam_role_policy_attachment
terrahub import --batch ${LOCAL_PATH}/landing_zone_iam_role_policy_attachment/eurechean.tfimport \
  --include landing_zone_iam_role_policy_attachment
terrahub import --batch ${LOCAL_PATH}/landing_zone_iam_role_policy_attachment/vcalmic.tfimport \
  --include landing_zone_iam_role_policy_attachment
terrahub import --batch ${LOCAL_PATH}/landing_zone_iam_role_policy_attachment/aluchianic.tfimport \
  --include landing_zone_iam_role_policy_attachment

##################################
# landing_zone_iam_saml_provider #
##################################
terrahub import --batch ${LOCAL_PATH}/landing_zone_iam_saml_provider/default.tfimport \
  --include landing_zone_iam_saml_provider

#####################################
# landing_zone_iam_instance_profile #
#####################################
terrahub import --batch ${LOCAL_PATH}/landing_zone_iam_instance_profile/default.tfimport \
  --include landing_zone_iam_instance_profile

####################
# landing_zone_eip #
####################
terrahub import --batch ${LOCAL_PATH}/landing_zone_eip/default.tfimport \
  --include landing_zone_eip

#######################
# delete remote state #
#######################
terrahub state -D aws_security_group_rule.landing_zone_security_group --include landing_zone_security_group \
  && terrahub state -D aws_security_group_rule.landing_zone_security_group-1 --include landing_zone_security_group \
  && terrahub state -D aws_security_group_rule.landing_zone_security_group_mitocgroup --include landing_zone_security_group \
  && terrahub state -D aws_security_group_rule.landing_zone_security_group_mitocgroup-1 --include landing_zone_security_group \
  && terrahub state -D aws_security_group_rule.landing_zone_security_group_terrahub --include landing_zone_security_group \
  && terrahub state -D aws_security_group_rule.landing_zone_security_group_terrahub --include landing_zone_security_group \
  && terrahub state -D aws_security_group_rule.landing_zone_security_group_terrahub-1 --include landing_zone_security_group \
  && terrahub state -D aws_security_group_rule.landing_zone_security_group_terrahub-2 --include landing_zone_security_group \
  && terrahub state -D aws_security_group_rule.landing_zone_security_group_terrahub-3 --include landing_zone_security_group \
  && terrahub state -D aws_security_group_rule.landing_zone_security_group_terrahub-4 --include landing_zone_security_group
