landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_config_delivery_channel_resource = {
    config_0 = {
      name           = "Landing-Zone-Delivery-Channel"
      s3_bucket_name = "awsconfig-bucket"
    }
  }
}
