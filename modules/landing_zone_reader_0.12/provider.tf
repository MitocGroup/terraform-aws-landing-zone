provider "aws" {
  region              = var.landing_zone_providers["default"]["region"]
  allowed_account_ids = [var.landing_zone_providers["default"]["account_id"]]
}

