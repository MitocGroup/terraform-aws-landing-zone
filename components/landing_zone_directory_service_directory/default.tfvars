landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_subnet_data = {
    config_0 = {
      availability_zone = "us-east-1a"
    },
    config_1 = {
      availability_zone = "us-east-1b"
    }
  },
  landing_zone_directory_service_resource = {
    config_0 = {
      name        = "corp.mycompany.com"
      short_name  = "CORP"
      password    = ""
      alias       = "mycompany"
      description = "My Company Group Active Directory"
      edition     = "Standard"
      enable_sso  = "false"
      size        = "Small"
      type        = "MicrosoftAD"
    }
  }
}
