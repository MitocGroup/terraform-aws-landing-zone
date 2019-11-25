landing_zone_providers = [
  "default"
]

default_provider = {
  s3_bucket_policy_resource = {
    config_0 = {
      bucket_name      = "data-lake-cloudtrail"
      policy_file_name = "policy"
    }
  }
}
