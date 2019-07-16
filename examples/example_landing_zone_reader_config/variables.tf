variable "landing_zone_providers" {
  type        = "map"
  description = "The list of AWS providers."
}

variable "landing_zone_components" {
  type        = "map"
  description = "This is the list of AWS Landing Zone components that will be deployed if corresponding `.tfvars` file is included."
}
