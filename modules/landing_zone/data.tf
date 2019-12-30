data "local_file" "landing_zone_output_file" {
  depends_on = [
    null_resource.terraform_output,
    null_resource.landing_zone_apply
  ]
  filename   = pathexpand(var.terraform_output_path)
}
