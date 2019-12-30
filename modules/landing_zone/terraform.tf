terraform {
  backend "local" {
    path = "/tmp/.terrahub/local_backend/terraform-aws-landing-zone/landing_zone/terraform.tfstate"
  }
}
