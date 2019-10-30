landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_config_configuration_aggregator_tags = {
    config_0 = {
      Description = "Managed by TerraHub"
      ThubCode    = "1234abcd"
      ThubEnv     = "Prod"
      Name        = "Landing Zone Configuration Aggregator"
    }
  },
  landing_zone_config_configuration_aggregator_resource = {
    config_0 = {
      name        = "Landing Zone Configuration Aggregator"
      account_ids = "123456789012"
      regions     = "us-east-1"
    }
  }
}
