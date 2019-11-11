landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_vpc_data = {
    config_0 = {
      cidr_block = "172.16.0.0/16"
    }
  },
  landing_zone_subnets_data                    = {},
  landing_zone_security_groups_data            = {}
  landing_zone_vpc_endpoint_interface_tags     = {},
  landing_zone_vpc_endpoint_interface_resource = {}
}
