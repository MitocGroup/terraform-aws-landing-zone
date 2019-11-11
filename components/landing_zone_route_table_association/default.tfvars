landing_zone_providers = [
  "default",
]

default_provider = {
  landing_zone_vpc_data = {
    config_0 = {
      cidr_block = "172.16.0.0/16"
    }
  },
  landing_zone_subnet_data = {
    config_0 = {
      cidr_block = "172.16.1.0/24"
    },
    config_1 = {
      cidr_block = "172.16.0.0/24"
    }
  },
  landing_zone_route_table_data = {
    config_0 = {
      filter_tag_name         = "Landing Zone Route Table"
      filter_association_main = "false"
    }
  }
}
