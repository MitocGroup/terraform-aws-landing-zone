landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_vpc_data = {
    config_0 = {
      cidr_block = "172.16.0.0/16"
    }
  },
  landing_zone_tgw_tags = {
    config_0 = {
      Name = "Landing Zone TGW VPC Attachment"
    }
  },
  landing_zone_tgw_resource = {
    config_0 = {
      transit_gateway_default_route_table_association = true
      transit_gateway_default_route_table_propagation = true
    }
  }
}
