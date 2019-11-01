landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_ssm_association_by_targets_resource = {
    config_0 = {
      name                = "MyCompany SSM Document"
      association_name    = ""
      document_version    = "2.2"
      schedule_expression = ""
      compliance_severity = "LOW"
      max_concurrency     = 10
      max_errors          = 10
      ol_s3_bucket_name   = "mycompany-bucket"
      ol_s3_key_prefix    = ""
      targets_key_1       = "Tag:Name"
      targets_value_1     = "MyCompany's EC2 Instance"
    }
  },
  landing_zone_ssm_association_by_targets_resource_arg_parameters = {
    config_0 = {
      Key = "Value"
    # Key = "Value"
    }
  }
}
