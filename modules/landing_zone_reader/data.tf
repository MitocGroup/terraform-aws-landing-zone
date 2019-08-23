data "terraform_remote_state" "terrahub_load_outputs" {
  backend = "s3"

  config = {
    bucket = "tfstates-euliancom"
    region = "us-east-1"
    key = "terraform/terrahub/api/terrahub_load_outputs/terraform.tfstate"
  }
}
