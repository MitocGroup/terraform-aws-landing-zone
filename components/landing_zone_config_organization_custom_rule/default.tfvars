landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_config_organization_custom_rule_resource = {
    config_0 = {
      name                 = "LandingZoneCustomRule"
      lambda_function_name = "LandingZoneLambda"
      trigger_types        = "ConfigurationItemChangeNotification"
    }
  }
}
