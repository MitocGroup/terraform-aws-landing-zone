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
  landing_zone_subnet_data = {
    config_0 = {
      cidr_block = "172.16.1.0/24"
    },
    config_1 = {
      cidr_block = "172.16.0.0/24"
    }
  },
  landing_zone_tgw_tags_element = {
    config_0 = {
      Name = "Landing Zone TGW VPC Attachment"
    }
  },
  landing_zone_tgw_element = {
    config_0 = {
      dns_support                                     = "enable"
      ipv6_support                                    = "disable"
      transit_gateway_default_route_table_association = true
      transit_gateway_default_route_table_propagation = true
      subnets_from_index                              = "0"
      subnets_to_index                                = "2"
    }
  }
}
