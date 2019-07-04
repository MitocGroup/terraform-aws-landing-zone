output "landing_zone" {
  depends_on  = [null_resource.landing_zone_apply]
  sensitive   = true
  value       = jsondecode(data.local_file.landing_zone_output_file.content)
  description = "The map of all output variables from components."
}

