output "landing_zone_reader" {
  depends_on = ["data.terraform_remote_state.terrahub_load_outputs"]

  sensitive   = true
  value       = "${data.terraform_remote_state.terrahub_load_outputs.terrahub_reader}"
  description = "The map of all output variables from components."
}
