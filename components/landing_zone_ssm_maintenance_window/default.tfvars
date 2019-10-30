landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_ssm_maintenance_window_resource = {
    config_0 = {
      name                       = "mycompany-maintenance-window-application"
      schedule                   = "cron(0 16 ? * TUE *)"
      cutoff                     = 1
      duration                   = 3
      allow_unassociated_targets = false
      enabled                    = true
      end_date                   = ""
      schedule_timezone          = ""
      start_date                 = ""
    }
  },
  landing_zone_ssm_maintenance_window_tags = {
    config_0 = {
      Description = "Managed by TerraHub"
      ThubCode    = "1234abcd"
      ThubEnv     = "Prod"
      Name        = "mycompany-maintenance-window-application"
    }
  }
}
