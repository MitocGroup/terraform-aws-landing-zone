landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_cloudtrail_s3_bucket_logging = {
    config_0 = {
      target_bucket = "landing-zone-s3-access-logs-123456789012-us-east-1"
    }
    config_1 = {}
  }
  landing_zone_cloudtrail_s3_bucket_lifecycle_rule = {
    config_0 = {
      abort_incomplete_multipart_upload_days  = 0
      enabled                                 = true
      id                                      = "RetentionRule"
      noncurrent_version_expiration_days      = 365
      expiration_days                         = 365
      expiration_expired_object_delete_marker = false
    }
    config_1 = {}
  }
  landing_zone_cloudtrail_s3_bucket_resource = {
    config_0 = {
      name          = "aws-landing-zone-logs-123456789012-us-east-1"
      versioning    = true
      sse_algorithm = "AES256"
    }
    config_1 = {
      name          = "aws-landing-zone-s3-access-logs-123456789012-us-east-1"
      versioning    = true
      sse_algorithm = "AES256"
    }
  }
}
