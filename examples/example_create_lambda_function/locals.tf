locals {
  landing_zone_subnet_ids         = "${module.landing_zone_reader.landing_zone_reader["landing_zone_subnet_ids"]}"
  landing_zone_security_group_ids = "${module.landing_zone_reader.landing_zone_reader["landing_zone_security_group_ids"]}"
}
