landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_tgw_data = {
    config_0 = {
      amazon_side_asn = 64512
    }
  },
  landing_zone_tgw_route_table_resource = {
    config_0 = {
      Name = "Landing Zone Transit Gateway"
    }
  }
}
