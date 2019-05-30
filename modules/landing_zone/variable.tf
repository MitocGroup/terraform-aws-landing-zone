variable "landing_zone_command" {
  type = "string"
  description = "The command that will be run by `terrahub` in this component."
  default = "run"
}

variable "landing_zone_components" {
  type = "map"
  description = "List of components to be run with his `tfvars` file."
}

variable "region" {
  type = "string"
  description = "This is the AWS region. It must be provided, but it can also be sourced from the AWS_DEFAULT_REGION environment variables, or via a shared credentials file if profile is specified."
}

variable "account_id" {
  type = "string"
  description = "AWS account ID to prevent you from mistakenly using an incorrect one (and potentially end up destroying a live environment)."
}