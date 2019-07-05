# output "landing_zone_vpc_ids" {
#   value       = "${module.landing_zone_reader.landing_zone_reader["landing_zone_vpc_ids"]}"
#   description = "The ID's of the VPC."
# }

# output "landing_zone_vpc_arns" {
#   value       = "${module.landing_zone_reader.landing_zone_reader["landing_zone_vpc_arns"]}"
#   description = "The ARN's of the VPC."
# }

output "landing_zone_subnet_ids" {
  value       = "${module.landing_zone_reader.landing_zone_reader}"
  description = "The ID's of the Subnet."
}

# output "landing_zone_subnet_availability_zone_ids" {
#   value       = "${module.landing_zone_reader.landing_zone_reader["landing_zone_subnet_availability_zone_ids"]}"
#   description = "The Availability Zone ID's of the Subnet."
# }

# output "landing_zone_subnet_arns" {
#   value       = "${module.landing_zone_reader.landing_zone_reader["landing_zone_subnet_arns"]}"
#   description = "The ARN's of the Subnet."
# }
