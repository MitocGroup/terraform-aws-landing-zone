landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_ssm_patch_baseline_resource = {
    config_0 = {
      name                              = "patch-baseline"
      description                       = "Patch Baseline Description"
      operating_system                  = "WINDOWS"
      approved_patches_compliance_level = "UNSPECIFIED"
      approved_patches                  = "KB123456|KB456789"
      rejected_patches                  = "KB987654"

      global_filter_key_1    = "CLASSIFICATION"
      global_filter_values_1 = "ServicePacks"

      ar_approve_after_days_1 = 7
      patch_filter_key_1      = "PRODUCT"
      patch_filter_values_1   = "WindowsServer2016"
      compliance_level_1      = "HIGH"
      enable_non_security_1   = false
    }
  },
  landing_zone_ssm_patch_baseline_tags = {
    config_0 = {
      Description = "Managed by TerraHub"
      ThubCode    = "1234abcd"
      ThubEnv     = "Prod"
      Name        = "Patch Baseline"
    }
  }
}
