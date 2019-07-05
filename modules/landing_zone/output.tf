output "landing_zone" {
  depends_on  = ["null_resource.landing_zone_apply"]
  sensitive   = true
  # value       = "${data.template_file.landing_zone_output_file.rendered}"
  # value       = "${file("${var.root_path}/output.json")}"
  value       = "${data.external.landing_zone_output_file.result}"
  description = "The map of all output variables from components."
}
