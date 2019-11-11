landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_config_aggregate_authorization_tags = {
    config_0 = {
      Description = "Managed by TerraHub"
      ThubCode    = "1234abcd"
      ThubEnv     = "Prod"
      Name        = "Landing Zone Configuration Aggregator Auth"
    }
  }
}
