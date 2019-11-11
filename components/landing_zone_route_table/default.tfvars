landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_vpc_data = {
    config_0 = {
      cidr_block = "172.16.0.0/16"
    }
  },
  landing_zone_route_table_tags = {
    config_0 = {
      Name = "Landing Zone Route Table"
    }
  },
  landing_zone_route_table_resource = {
    config_0 = {}
  }
}
