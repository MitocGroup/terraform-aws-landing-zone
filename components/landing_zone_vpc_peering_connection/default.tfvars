landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_vpc_peering_connection_data = {
    config_0 = {
      vpc_cidr_block      = "172.16.0.0/16"
      peer_vpc_cidr_block = "172.16.0.0/16"
    }
  },
  landing_zone_vpc_peering_connection_resource = {}
  landing_zone_vpc_peering_connection_tags     = {},
}
