landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_instance_data = {
    config_0 = {
      name = "MyCompany's EC2 Instance"
    }
  },
  landing_zone_ssm_association_by_instance_id_resource = {
    config_0 = {
      name                = "MyCompany SSM Document"
      association_name    = ""
      document_version    = ""
      schedule_expression = ""
      compliance_severity = "LOW"
      max_concurrency     = 10
      max_errors          = 10
      ol_s3_bucket_name   = "mycompany-bucket"
      ol_s3_key_prefix    = ""
    }
  },
  landing_zone_ssm_association_by_instance_id_resource_arg_parameters = {
    config_0 = {
      Key = "Value"
    # Key = "Value"
    }
  }
}
