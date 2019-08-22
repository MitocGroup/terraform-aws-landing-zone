module "example_landing_zone_reader_config" {
  source                  = "../../modules/landing_zone_reader_config"
  root_path               = "${path.cwd}/../.."
  landing_zone_providers  = var.landing_zone_providers
  landing_zone_backend    = var.landing_zone_backend
  landing_zone_components = var.landing_zone_components
}
