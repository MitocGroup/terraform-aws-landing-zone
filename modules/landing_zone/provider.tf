provider "aws" {
  region              = "${var.region}"
  allowed_account_ids = ["${var.account_id}"]
}
