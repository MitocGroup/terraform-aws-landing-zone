#!/usr/bin/env bash

LZ_LOCAL_PATH="./components"
LZ_TFIMPORT_FILENAME="default.tfimport"
LZ_COMPONENTS=(
  "landing_zone_eip"
  "landing_zone_gateway_igw"
  "landing_zone_gateway_nat"
  "landing_zone_iam_instance_profile"
  "landing_zone_iam_policy"
  "landing_zone_iam_role"
  "landing_zone_iam_role_policy_attachment"
  "landing_zone_iam_saml_provider"
  "landing_zone_network_acl"
  "landing_zone_network_acl_rules"
  "landing_zone_organization"
  "landing_zone_organization_accounts"
  "landing_zone_route"
  "landing_zone_route_igw"
  "landing_zone_route_ipv6"
  "landing_zone_route_pcx"
  "landing_zone_route_table"
  "landing_zone_route_table_association"
  "landing_zone_security_group"
  "landing_zone_security_group_rule_egress"
  "landing_zone_security_group_rule_ingress"
  "landing_zone_subnet"
  "landing_zone_vpc"
  "landing_zone_vpc_endpoint_gateway"
  "landing_zone_vpc_endpoint_interface"
  "landing_zone_vpc_peering_connection"
  )

###################
# terrahub import #
###################
for LZ_COMPONENT in "${LZ_COMPONENTS[@]}"; do
  terrahub import --batch ${LZ_LOCAL_PATH}/${LZ_COMPONENT}/${LZ_TFIMPORT_FILENAME}  --include ${LZ_COMPONENT}
done

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
