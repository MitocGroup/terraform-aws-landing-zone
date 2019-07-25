data "local_file" "landing_zone_output_file" {
  depends_on = [null_resource.landing_zone_apply]
  filename   = pathexpand("~/.terrahub/cache/landing_zone/output.json")
}
