module "landing_zone" {
  source                  = "./modules/landing_zone"
  version                 = "0.0.6"
  root_path               = "${path.module}"
  account_id              = "${var.account_id}"
  region                  = "${var.region}"
  landing_zone_components = "${var.landing_zone_components}"
}
