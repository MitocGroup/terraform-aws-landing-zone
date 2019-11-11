landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_vpc_data = {
    config_0 = {
      cidr_block = "172.16.0.0/16"
    }
  },
  landing_zone_gateway_tgw_data = {
    config_0 = {
      amazon_side_asn = 64512
    }
  },
  landing_zone_tgw_route_resource = {
    config_0 = {
      destination_cidr_block = "0.0.0.0/0"
    }
  }
}
