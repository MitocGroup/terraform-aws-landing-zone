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
      cidr_block         = "172.16.1.0/24|172.16.0.0/24"
      subnets_from_index = "0"
      subnets_to_index   = "2"
    }
  },
  landing_zone_network_acl_resource = {
    config_0 = {
      Description = "Managed by TerraHub"
      ThubCode    = "1234abcd"
      ThubEnv     = "Prod"
    }
  }
}
