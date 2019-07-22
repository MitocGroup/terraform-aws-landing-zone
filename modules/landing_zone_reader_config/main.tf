resource "null_resource" "landing_zone_reader_config" {
  triggers = {
    providers  = md5(jsonencode(var.landing_zone_providers))
    components = md5(jsonencode(var.landing_zone_components))
  }

  provisioner "local-exec" {
    when    = "create"
    command = "node ${path.module}/scripts/config.js"

    environment = {
      ROOT_PATH  = var.root_path
      PROVIDERS  = jsonencode(var.landing_zone_providers)
      COMPONENTS = jsonencode(var.landing_zone_components)
    }
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "node ${path.module}/scripts/remove-config.js"

    environment = {
      ROOT_PATH  = var.root_path
      COMPONENTS = jsonencode(var.landing_zone_components)
    }
  }
}

resource "null_resource" "landing_zone_reader_apply" {
  depends_on = ["null_resource.landing_zone_reader_config"]

  triggers = {
    components = md5(jsonencode(var.landing_zone_components))
    timestamp  = timestamp()
  }

  provisioner "local-exec" {
    when    = "create"
    command = "node ${path.module}/scripts/apply.js"

    environment = {
      ROOT_PATH  = var.root_path
      COMPONENTS = jsonencode(var.landing_zone_components)
    }
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "echo 'info: destroy ignored because part of apply'"
  }
}
