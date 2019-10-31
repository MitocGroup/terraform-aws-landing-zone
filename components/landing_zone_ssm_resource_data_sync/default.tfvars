landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_ssm_resource_data_sync_resource = {
    config_0 = {
      name                = "MyCompany Data Sync"
      s3_dest_bucket      = "my-company-tf-test-bucket-1234"
      s3_dest_region      = "us-east-1"
      s3_dest_prefix      = ""
      s3_dest_sync_format = ""
    }
  },
  landing_zone_kms_key_data = {}
}
