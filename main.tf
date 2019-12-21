module "landing_zone" {
  source                  = "./modules/landing_zone"
  root_path               = path.module
  landing_zone_providers  = var.landing_zone_providers
  landing_zone_components = var.landing_zone_components
  terraform_backend       = var.terraform_backend
  terraform_config        = var.terraform_config
  terraform_command       = var.terraform_command
}
