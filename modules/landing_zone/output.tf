output "landing_zone" {
  depends_on  = [data.local_file.landing_zone_output_file]
  sensitive   = true
  value       = data.local_file.landing_zone_output_file.content == "" ? jsondecode("\"null\":{\"default\":[\"null\"]}") : jsondecode(data.local_file.landing_zone_output_file.content)
  description = "The map of all output variables from components."
}
