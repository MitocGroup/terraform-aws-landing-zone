data "terraform_remote_state" "terrahub_load_outputs" {
  backend = "local"

  config = {
    path = "/tmp/.terrahub/landing_zone/terrahub_load_outputs/terraform.tfstate"
  }
}
