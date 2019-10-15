locals {
  landing_zone_iam_role_arns      = module.example_landing_zone_reader.landing_zone_reader["landing_zone_iam_role_arns"]
  landing_zone_subnet_ids         = module.example_landing_zone_reader.landing_zone_reader["landing_zone_subnet_ids"]
  landing_zone_security_group_ids = module.example_landing_zone_reader.landing_zone_reader["landing_zone_security_group_ids"]
}
