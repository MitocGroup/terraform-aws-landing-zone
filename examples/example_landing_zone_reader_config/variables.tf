variable "landing_zone_providers" {
  type        = map(map(string))
  description = "The list of AWS providers."
}

variable "landing_zone_backend" {
  type        = map(string)
  description = "This is the backend configure for all components."
}

variable "landing_zone_components" {
  type        = map(string)
  description = "This is the list of AWS Landing Zone components that will be deployed if corresponding `.tfvars` file is included."
}
