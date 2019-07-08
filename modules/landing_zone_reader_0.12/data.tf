data "local_file" "landing_zone_reader_output_file" {
  depends_on = [null_resource.landing_zone_reader_apply]
  filename   = "${var.root_path}/output.json"
}
