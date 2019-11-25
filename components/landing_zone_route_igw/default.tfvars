landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_vpc_data = {
    config_0 = {
      cidr_block = "172.16.0.0/16"
    }
  },
  landing_zone_route_table_data = {
    config_0 = {
      name = "Landing Zone Route Table"
    }
  },
  landing_zone_route_igw_resource = {
    config_0 = {
      destination_cidr_block = "0.0.0.0/0"
    }
  }
}
