data "local_file" "landing_zone_reader_output_file" {
  depends_on = [null_resource.landing_zone_reader_apply]
  filename   = "${var.root_path}/output.json"
}

# data "external" "landing_zone_reader_output_file" {
#   depends_on = [data.local_file.landing_zone_reader_output_file]
#   program    = ["sh", "${path.module}/scripts/output.sh", "${var.root_path}/output.json"]
# }
