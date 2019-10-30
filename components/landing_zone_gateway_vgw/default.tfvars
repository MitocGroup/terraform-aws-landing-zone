landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_vpc_data = {
    config_0 = {
      cidr_block = "172.16.0.0/16"
    }
  },
  landing_zone_gateway_vgw_tags = {
    config_0 = {
      Description = "Managed by TerraHub"
      ThubCode    = "1234abcd"
      ThubEnv     = "Prod"
      Name        = "Landing Zone Customer Gateway"
    }
  },
  landing_zone_gateway_vgw_resource = {
    config_0 = {
      availability_zone = "us-east-1c"
    }
  }
}
