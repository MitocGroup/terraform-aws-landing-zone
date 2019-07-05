data "external" "landing_zone_output_file" {
  depends_on = ["null_resource.landing_zone_apply"]
  program    = ["sh", "${path.module}/scripts/output.sh", "${var.root_path}/output.json"]
}

# data "template_file" "landing_zone_output_file" {
#   depends_on = ["null_resource.landing_zone_apply"]
#   template = "${file("${var.root_path}/output.json")}"
# }

# data "external" "landing_zone_output_file" {
#   depends_on = ["data.template_file.landing_zone_output_file"]
#   program    = ["echo", "${data.template_file.landing_zone_output_file.rendered}", "|", "jq", "."]
# }
