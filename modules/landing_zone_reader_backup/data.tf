data "external" "landing_zone_reader_output_file" {
  depends_on = ["null_resource.landing_zone_reader_apply"]
  program    = ["sh", "${path.module}/scripts/output.sh", "${var.root_path}/output.json"]
}
