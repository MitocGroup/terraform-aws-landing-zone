landing_zone_providers = [
  "default"
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
    }
  },
  landing_zone_route_igw_resource = {
    config_0 = {
      destination_cidr_block = "0.0.0.0/0"
    }
  }
}
