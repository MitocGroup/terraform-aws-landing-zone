landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_vpc_tags = {
    config_0 = {
      Description       = "Managed by TerraHub"
      AWSServiceAccount = ""
      ThubCode          = "1234abcd"
      ThubEnv           = "Prod"
      Name              = "VPC for Landing Zone"
    }
  },
  landing_zone_vpc_resource = {
    config_0 = {
      cidr_block                       = "172.16.0.0/16"
      instance_tenancy                 = "default"
      enable_dns_support               = "true"
      assign_generated_ipv6_cidr_block = "false"
      enable_classiclink               = "false"
      enable_dns_hostnames             = "false"
      enable_classiclink_dns_support   = "false"
    }
  }
}
