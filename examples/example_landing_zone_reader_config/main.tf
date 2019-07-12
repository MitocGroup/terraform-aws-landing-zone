module "example_landing_zone_reader_config" {
  source                  = "../../modules/landing_zone_reader_config"
  version                 = "0.0.8"
  root_path               = "${path.cwd}/../.."
  landing_zone_providers  = "${var.landing_zone_providers}"
  landing_zone_components = "${var.landing_zone_components}"
}
