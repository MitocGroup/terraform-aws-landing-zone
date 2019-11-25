landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_cloudtrail_s3_bucket_resource = {
    config_0 = {
      name       = "euliancom-data-lake-cloudtrail"
      versioning = true
    }
  }
}
