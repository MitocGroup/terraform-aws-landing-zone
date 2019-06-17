variable "root_path" {
  type = "string"
}

variable "account_id" {
  type        = "string"
  description = "AWS account ID to prevent you from mistakenly using an incorrect one (and potentially end up destroying a live environment)."
}

variable "region" {
  type        = "string"
  description = "This is the AWS region. It must be provided, but it can also be sourced from the AWS_DEFAULT_REGION environment variables, or via a shared credentials file if profile is specified."
}

variable "landing_zone_components" {
  type        = "map"
  description = "This is the list of AWS Landing Zone components that will be deployed if corresponding `.tfvars` file is included."
}

variable "landing_zone_command" {
  type        = "string"
  default     = "apply"
  description = "The command that will be executed by `terrahub` in this component."
}
