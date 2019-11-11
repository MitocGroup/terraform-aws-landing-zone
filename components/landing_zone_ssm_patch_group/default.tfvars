landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_ssm_patch_group_resource = {
    config_0 = {
      patch_group = "patch-group-name"
    }
  }
}
