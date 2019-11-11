landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_ssm_document_resource = {
    config_0 = {
      name                    = "MyCompany SSM Document"
      document_format         = "JSON"
      document_type           = "Command"
      permissions_type        = ""
      permissions_account_ids = ""
      content                 = <<EOT
      {
          "schemaVersion": "1.2",
          "description": "",
          "parameters": {},
          "runtimeConfig": {
              "aws:runShellScript": {
                  "properties": [{
                      "id": "0.aws:runShellScript",
                      "runCommand": ["ifconfig"]
                  }]
              }
          }
      }
      EOT
    }
  },
  landing_zone_ssm_document_tags = {
    config_0 = {
      Description = "Managed by TerraHub"
      ThubCode    = "1234abcd"
      ThubEnv     = "Prod"
      Name        = "MyCompany SSM Document"
    }
  }
}
