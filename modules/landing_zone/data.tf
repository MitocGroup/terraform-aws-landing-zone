data "external" "landing_zone_output_file" {
  depends_on = ["null_resource.landing_zone"]
  program = ["cat", "${var.root_path}/output.json"]
}
