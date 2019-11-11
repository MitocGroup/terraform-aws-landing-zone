landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_ssm_maintenance_window_target_resource = {
    config_0 = {
      name          = "mycompany-maintenance-window-target"
      description   = "Managed by TerraHub"
      resource_type = "INSTANCE"
      target_key    = "tag:Name"
      target_values = "MyCompany's EC2 Instance"
    }
  }
}
