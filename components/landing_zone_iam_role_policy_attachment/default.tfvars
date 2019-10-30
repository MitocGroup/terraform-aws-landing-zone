landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_iam_role_policy_attachement_resource = {
    config_0 = {
      role       = "LandingZoneIAMRole"
      policy_arn = "arn:aws:iam::123456789012:policy/LandingZoneIAMRolePolicy"
    }
  }
}