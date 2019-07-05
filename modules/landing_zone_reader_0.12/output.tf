output "landing_zone_reader" {
  depends_on  = [data.local_file.landing_zone_reader_output_file]
  sensitive   = true
  value       = jsondecode(data.local_file.landing_zone_reader_output_file.content)
  description = "The map of all output variables from components."
}
