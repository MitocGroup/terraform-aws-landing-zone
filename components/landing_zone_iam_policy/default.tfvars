landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_iam_policy_data = {
    config_0 = {
      effect_status = "Allow"
    }
  },
  landing_zone_iam_policy_resource = {
    config_0 = {
      name        = "ServicePolicyForADroles"
      description = "Managed By TerraHub"
      path        = "/"
    }
  }
}
