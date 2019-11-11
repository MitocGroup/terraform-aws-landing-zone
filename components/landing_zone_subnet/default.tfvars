landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_vpc_data = {
    config_0 = {
      cidr_block = "172.16.0.0/16"
    }
  }
  landing_zone_subnet_tags = {
    config_0 = {
      Description       = "Managed by TerraHub"
      AWSServiceAccount = ""
      ThubCode          = "1234abcd"
      ThubEnv           = "Prod"
      Name              = "Landing Zone Subnet Private (us-east-1c)"
    },
    config_1 = {
      Description       = "Managed by TerraHub"
      AWSServiceAccount = ""
      ThubCode          = "1234abcd"
      ThubEnv           = "Prod"
      Name              = "Landing Zone Subnet Private (us-east-1a)"
    }
  }
  landing_zone_subnet_resource = {
    config_0 = {
      cidr_block                      = "172.16.1.0/24"
      availability_zone               = "us-east-1c"
      assign_ipv6_address_on_creation = "false"
    },
    config_1 = {
      cidr_block                      = "172.16.0.0/24"
      availability_zone               = "us-east-1a"
      assign_ipv6_address_on_creation = "false"
    }
  }
}
