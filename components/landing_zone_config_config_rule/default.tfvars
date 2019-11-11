landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_config_config_rule_tags = {
    config_0 = {
      Description = "Managed by TerraHub"
      ThubCode    = "1234abcd"
      ThubEnv     = "Prod"
      Name        = "Landing Zone Config Rule"
    }
  },
  landing_zone_config_config_rule_resource = {
    config_0 = {
      name              = "Landing Zone Config Rule"
      description       = "Description"
      source_owner      = "AWS"
      source_identifier = "S3_BUCKET_VERSIONING_ENABLED"
    }
  }
}
