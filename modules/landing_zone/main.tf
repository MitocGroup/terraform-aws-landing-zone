resource "null_resource" "landing_zone" {
  triggers = {
    command = "${var.landing_zone_command}"
    components = "${md5(jsonencode(var.landing_zone_components))}"
    timestamp = "${timestamp()}"
  }

  "provisioner" "local-exec" {
    command = "sh ${path.module}/scripts/apply.sh"
    environment = {
      ROOT_PATH = "${var.root_path}"
      COMMAND = "${var.landing_zone_command}"
      COMPONENTS = "${jsonencode(var.landing_zone_components)}"
    }
  }
}
