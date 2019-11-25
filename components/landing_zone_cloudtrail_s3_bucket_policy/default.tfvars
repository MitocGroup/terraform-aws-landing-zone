landing_zone_providers = [
  "default"
]

default_provider = {
  s3_bucket_policy_resource = {
    config_0 = {
      bucket_name      = "euliancom-data-lake-cloudtrail-us-east-1"
      policy_file_name = "policy"
    }
  }
}
