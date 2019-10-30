landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_eip_tags_resource = {
    config_0 = {
      Description = "Managed by TerraHub"
      ThubCode    = "1234abcd"
      ThubEnv     = "Prod"
      Name        = "Landing Zone Elastic IP"
    }
  },
  landing_zone_eip_resource = {
    config_0 = {
      vpc = "true"
    }
  }
}
