landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_vpc_data = {
    config_0 = {
      cidr_block = "172.16.0.0/16"
    }
  },
  landing_zone_security_group_tags = {
    config_0 = {
      Description = "Managed by TerraHub"
      ThubCode    = "1234abcd"
      ThubEnv     = "Prod"
      Name        = "Landing Zone Security Group"
    }
  }
  landing_zone_security_group_resource = {
    config_0 = {
      name        = "landing_zone"
      description = "default VPC security group"
    }
  }
}
