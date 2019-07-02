output "landing_zone_vpc_ids" {
  value       = "${module.landing_zone.landing_zone["landing_zone_vpc_ids"]}"
  description = "The ID's of the VPC."
}

output "landing_zone_vpc_arns" {
  value       = "${module.landing_zone.landing_zone["landing_zone_vpc_arns"]}"
  description = "The ARN's of the VPC."
}

output "landing_zone_subnet_ids" {
  value       = "${module.landing_zone.landing_zone["landing_zone_subnet_ids"]}"
  description = "The ID's of the Subnet."
}

output "landing_zone_subnet_availability_zone_ids" {
  value       = "${module.landing_zone.landing_zone["landing_zone_subnet_availability_zone_ids"]}"
  description = "The Availability Zone ID's of the Subnet."
}

output "landing_zone_subnet_arns" {
  value       = "${module.landing_zone.landing_zone["landing_zone_subnet_arns"]}"
  description = "The ARN's of the Subnet."
}

output "landing_zone_gateway_igw_ids" {
  value       = "${module.landing_zone.landing_zone["landing_zone_gateway_igw_ids"]}"
  description = "The ID's of the Internet Gateway."
}

output "landing_zone_route_table_ids" {
  value       = "${module.landing_zone.landing_zone["landing_zone_route_table_ids"]}"
  description = "The ID's of the Route Table."
}

output "landing_zone_route_ids" {
  value       = "${module.landing_zone.landing_zone["landing_zone_route_ids"]}"
  description = "The ID's of the Route."
}

output "landing_zone_route_igw_ids" {
  value       = "${module.landing_zone.landing_zone["landing_zone_route_igw_ids"]}"
  description = "The ID's of the Local Route."
}

output "landing_zone_network_acl_ids" {
  value       = "${module.landing_zone.landing_zone["landing_zone_network_acl_ids"]}"
  description = "The ID's of the Network ACL."
}

output "landing_zone_security_group_ids" {
  value       = "${module.landing_zone.landing_zone["landing_zone_security_group_ids"]}"
  description = "The ID's of the Security Group."
}
