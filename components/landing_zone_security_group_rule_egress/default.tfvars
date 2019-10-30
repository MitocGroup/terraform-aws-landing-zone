landing_zone_providers = [
  "default"
]

default_provider = {
  landing_zone_vpc_data = {
    config_0 = {
      cidr_block = "172.16.0.0/16"
    }
  },
  landing_zone_security_group_data = {
    config_0 = {
      name = "landing_zone"
    }
  },
  landing_zone_security_group_rule_resource = {
    config_0 = {
      protocol    = "all"
      from_port   = "0"
      to_port     = "0"
      cidr_blocks = "0.0.0.0/0"
      self        = "false"
    }
  }
}
