module "sample" {
  source = "./modules/landing_zone"
  landing_zone_components = "${var.landing_zone_components}"
  region = "${var.region}"
  account_id = "${var.account_id}"
  root_path = "${path.module}"
}
