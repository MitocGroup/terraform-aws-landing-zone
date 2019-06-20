resource "null_resource" "landing_zone_config" {
  triggers = {
    command    = "${var.landing_zone_command}"
    providers  = "${md5(jsonencode(var.landing_zone_providers))}"
    components = "${md5(jsonencode(var.landing_zone_components))}"
  }

  "provisioner" "local-exec" {
    when    = "create"
    command = "sh ${path.module}/scripts/config.sh"

    environment = {
      ROOT_PATH  = "${var.root_path}"
      COMMAND    = "${var.landing_zone_command}"
      PROVIDERS  = "${jsonencode(var.landing_zone_providers)}"
      COMPONENTS = "${jsonencode(var.landing_zone_components)}"
    }
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "python ${path.module}/scripts/remove_config.py"

    environment = {
      root       = "${var.root_path}"
      components = "${jsonencode(var.landing_zone_components)}"
    }
  }
}

resource "null_resource" "landing_zone_apply" {
  depends_on = ["null_resource.landing_zone_config"]

  triggers = {
    command    = "${var.landing_zone_command}"
    components = "${md5(jsonencode(var.landing_zone_components))}"
    timestamp  = "${timestamp()}"
  }

  "provisioner" "local-exec" {
    when    = "create"
    command = "sh ${path.module}/scripts/apply.sh"

    environment = {
      ROOT_PATH  = "${var.root_path}"
      COMMAND    = "${var.landing_zone_command}"
      COMPONENTS = "${jsonencode(var.landing_zone_components)}"
    }
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "echo 'info: destroy ignored because part of apply'"
  }
}

resource "null_resource" "landing_zone_destroy" {
  depends_on = ["null_resource.landing_zone_apply"]

  triggers = {
    components = "any component (or all components)"
  }

  provisioner "local-exec" {
    when    = "create"
    command = "echo 'info: apply ignored because part of destroy'"
  }

  "provisioner" "local-exec" {
    when    = "destroy"
    command = "python ${path.module}/scripts/destroy.py"

    environment = {
      root       = "${var.root_path}"
      components = "${jsonencode(var.landing_zone_components)}"
    }
  }
}
