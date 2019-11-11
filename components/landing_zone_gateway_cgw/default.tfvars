landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_gateway_cgw_tags_element = {
    config_0 = {
      Description = "Managed by TerraHub"
      ThubCode    = "1234abcd"
      ThubEnv     = "Prod"
      Name        = "Landing Zone Customer Gateway"
    }
  },
  landing_zone_gateway_cgw_resource = {
    config_0 = {
      bgp_asn    = 65000
      ip_address = "172.83.124.10"
      type       = "ipsec.1"
    }
  }
}
