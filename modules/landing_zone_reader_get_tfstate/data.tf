data "terraform_remote_state" "terrahub_load_outputs" {
  backend = "local"
  config = {
    path = "/tmp/.terrahub/tfstate_local/terraform-aws-landing-zone/terrahub_load_outputs/terraform.tfstate"
  }
}
