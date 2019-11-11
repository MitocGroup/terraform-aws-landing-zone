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
      cidr_block = "172.16.1.0/24"
    },
    config_1 = {
      cidr_block = "172.16.0.0/24"
    }
  },
  landing_zone_eip_data = {
    config_0 = {
      public_ip = ""
    },
    config_1 = {
      public_ip = ""
    }
  },
  landing_zone_gateway_nat_tags = {
    config_0 = {
      Description = "Managed by TerraHub"
      ThubCode    = "1234abcd"
      ThubEnv     = "Prod"
      Name        = "Landing Zone Gateway NAT"
    },
    config_1 = {
      Description = "Managed by TerraHub"
      ThubCode    = "1234abcd"
      ThubEnv     = "Prod"
      Name        = "Landing Zone Gateway NAT"
    }
  }
}
