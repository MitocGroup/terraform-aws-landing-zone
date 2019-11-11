landing_zone_providers = [
  "default"
]

landing_zone_cloudtrail_name                   = "Default"
landing_zone_cloudtrail_is_multi_region_trail  = true
landing_zone_cloudtrail_is_organization_trail  = true
landing_zone_event_selector_data_resource_type = "AWS::Lambda::Function"
landing_zone_event_selector_data_resource_values = [
  "arn:aws:lambda:us-east-1:123456789012:function:DeepProdSayHelloCreateDb",
  "arn:aws:lambda:us-east-1:123456789012:function:DeepProdSayHelloCreateFs",
  "arn:aws:lambda:us-east-1:123456789012:function:DeepProdSayHelloCreateMsg"
]
