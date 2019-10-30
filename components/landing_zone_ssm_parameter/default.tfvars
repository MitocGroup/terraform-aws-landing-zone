landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_ssm_parameter_resource = {
    config_0 = {
      name            = "/LandingZone/mycompany/Parameter"
      type            = "String"
      value           = "value"
      description     = "Managed by TerraHub"
      tier            = "Standard"
      key_id          = ""
      overwrite       = false
      allowed_pattern = ""
    }
  },
  landing_zone_ssm_parameter_tags = {
    config_0 = {
      Description = "Managed by TerraHub"
      ThubCode    = "1234abcd"
      ThubEnv     = "Prod"
      Name        = "/LandingZone/mycompany/Parameter"
    }
  }
}
