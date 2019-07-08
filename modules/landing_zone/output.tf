output "landing_zone" {
  depends_on  = ["null_resource.landing_zone_apply"]
  sensitive   = true
  value       = "${data.external.landing_zone_output_file.result}"
  description = "The map of all output variables from components."
}
