landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_vpc_data = {
    config_0 = {
      cidr_block = "172.16.0.0/16"
    }
  },
  landing_zone_network_acl_rule_resource = {
    config_0 = {
      rule_number = "100"
      protocol    = "-1"
      rule_action = "allow"
      egress      = "false"
      cidr_block  = "0.0.0.0/0"
    }
  }
}
