provider "aws" {
  region              = "${lookup(var.landing_zone_providers["default"], "region")}"
  allowed_account_ids = ["${lookup(var.landing_zone_providers["default"], "account_id")}"]
}
