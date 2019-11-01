data "terraform_remote_state" "terrahub_load_outputs" {
  backend = var.terraform_backend_type
  config  = var.terraform_backend_config
}
