output "landing_zone_reader" {
  depends_on  = [
    "module.read"
  ]
  sensitive   = true
  value       = "${module.read.landing_zone_reader}"
  description = "The map of all output variables from components."
}
