resource "null_resource" "landing_zone" {
  triggers = {
    command = "${var.landing_zone_command}"
    components = "${md5(jsonencode(var.landing_zone_components))}"
    timestamp = "${timestamp()}"
  }

  "provisioner" "local-exec" {
    command = "python ${path.module}/scripts/apply.py"
    environment = {
      root = "${local.project["path"]}"
      command = "${var.landing_zone_command}"
      components = "${jsonencode(var.landing_zone_components)}"
    }
  }
}
