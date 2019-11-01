variable "terraform_backend_type" {
  type        = string
  description = "The list of AWS providers."
}

variable "terraform_backend_config" {
  type        = map(string)
  description = "The list of AWS providers."
}
