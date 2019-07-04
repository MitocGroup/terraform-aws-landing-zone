module "landing_zone" {
  source                  = "./modules/landing_zone"
  root_path               = path.root
  landing_zone_providers  = var.landing_zone_providers
  landing_zone_components = var.landing_zone_components
}
