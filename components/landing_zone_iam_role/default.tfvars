landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_iam_role_resource = {
    config_0 = {
      name                 = "LandingZoneIAMRole"
      path                 = "/"
      description          = "Managed by TerraHub"
      max_session_duration = 3600
      assume_role_policy = <<EOF
        {
          "Version": "2012-10-17",
          "Statement": [
            {
              "Action": "sts:AssumeRole",
              "Principal": {
                "Service": "ec2.amazonaws.com"
              },
              "Effect": "Allow",
              "Sid": ""
            }
          ]
        }
      EOF
    }
  }
}
