landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_gateway_tgw_data = {
    config_0 = {
      amazon_side_asn = 64512
    }
  },
  landing_zone_route_table_tgw_tags = {
    config_0 = {
      Name = "Landing Zone Route Table"
    }
  }
}
