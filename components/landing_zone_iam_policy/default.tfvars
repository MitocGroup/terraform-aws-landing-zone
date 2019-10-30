landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_iam_policy_resource = {
    config_0 = {
      name        = "LandingZoneIAMPolicy"
      description = "Managed By TerraHub"
      path        = "/"
      policy      = <<EOF
        {
          "Version": "2012-10-17",
          "Statement": [
            {
              "Action": [
                "ec2:Describe*"
              ],
              "Effect": "Allow",
              "Resource": "*"
            }
          ]
        }
        EOF
    }
  }
}
