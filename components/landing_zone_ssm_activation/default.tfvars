landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_ssm_activation_resource = {
    config_0 = {
      name               = "MyCompany SSM Activation"
      description        = "Landing Zone SSM Activation"
      expiration_timeadd = "48h" // See [1]
      iam_role           = "Role_Name"
      registration_limit = 1
    }
  },
  landing_zone_ssm_activation_tags = {
    config_0 = {
      Description = "Managed by TerraHub"
      ThubCode    = "1234abcd"
      ThubEnv     = "Prod"
      Name        = "MyCompany SSM Activation"
    }
  }
}

/*
[1]
String representation of a time difference, consisting of sequences of number and unit pairs, like "1.5h" or "1h30m".
The accepted units are "ns", "us" (or "µs"), "ms", "s", "m", and "h".
The first number may be negative to indicate a negative duration, like "-2h5m"
*/
