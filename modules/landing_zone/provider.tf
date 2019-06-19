provider "aws" {
  region              = "${lookup(lookup(var.provider_aliases, "default"), "region")}"
  allowed_account_ids = ["${lookup(lookup(var.provider_aliases, "default"), "account_id")}"]
}
