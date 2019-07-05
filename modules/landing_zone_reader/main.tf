module "config" {
  source = "../landing_zone_reader_configure"
  root_path = "${var.root_path}"
  landing_zone_providers = "${var.landing_zone_providers}"
  landing_zone_components = "${var.landing_zone_components}"  
}

module "read" {
  source = "../landing_zone_reader_get_tfstate"
}
