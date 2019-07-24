data "local_file" "landing_zone_output_file" {
  depends_on = [null_resource.landing_zone_apply]
  filename   = var.output_path
}