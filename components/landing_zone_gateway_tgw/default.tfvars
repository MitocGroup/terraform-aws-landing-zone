landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_gateway_tgw_tags = {
    config_0 = {
      Description = "Managed by TerraHub"
      ThubCode    = "1234abcd"
      ThubEnv     = "Prod"
      Name        = "Landing Zone Transit Gateway"
    }
  },
  landing_zone_gateway_tgw_resource = {
    config_0 = {
      amazon_side_asn                 = 64512
      auto_accept_shared_attachments  = "disable"
      default_route_table_association = "disable"
      default_route_table_propagation = "disable"
      description                     = "Landing Zone Transit Gateway"
      dns_support                     = "disable"
      vpn_ecmp_support                = "disable"
    }
  }
}
