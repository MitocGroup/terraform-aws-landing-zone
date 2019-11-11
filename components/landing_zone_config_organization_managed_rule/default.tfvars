landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_config_organization_managed_rule_resource = {
    config_0 = {
      name            = "LandingZoneManagedRule"
      rule_identifier = "AWS_RULE_IDENTIFIER"
    }
  }
}
