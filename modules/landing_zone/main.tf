resource "null_resource" "terraform_config" {
  provisioner "local-exec" {
    command = var.terraform_config ? "mv .terrahub.yml.backup .terrahub.yml" : "echo 'Terraform config is ignore!'"
  }
}

resource "null_resource" "landing_zone_config" {  
  depends_on = [null_resource.terraform_config]

  triggers = {
    command    = var.terraform_command
    providers  = md5(jsonencode(var.landing_zone_providers))
    components = md5(jsonencode(var.landing_zone_components))
    backend    = md5(jsonencode(var.terraform_backend))
  }

  provisioner "local-exec" {
    when    = create
    command = "node ${path.module}/scripts/config.js"

    environment = {
      ROOT_PATH  = var.root_path
      COMMAND    = var.terraform_command
      PROVIDERS  = jsonencode(var.landing_zone_providers)
      COMPONENTS = jsonencode(var.landing_zone_components)
      BACKEND    = jsonencode(var.terraform_backend)
    }
  }

  provisioner "local-exec" {
    when    = destroy
    command = "node ${path.module}/scripts/remove-config.js"

    environment = {
      ROOT_PATH  = var.root_path
      COMPONENTS = jsonencode(var.landing_zone_components)
    }
  }
}

resource "null_resource" "landing_zone_apply" {
  depends_on = [null_resource.landing_zone_config]

  triggers = {
    command    = var.terraform_command
    components = md5(jsonencode(var.landing_zone_components))
    timestamp  = timestamp()
  }

  provisioner "local-exec" {
    when    = create
    command = "node ${path.module}/scripts/apply.js"

    environment = {
      OUTPUT_PATH = pathexpand("~/.terrahub/cache/landing_zone/output.json")
      ROOT_PATH   = var.root_path
      COMMAND     = var.terraform_command
      COMPONENTS  = jsonencode(var.landing_zone_components)
    }
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'info: destroy ignored because part of apply'"
  }
}

resource "null_resource" "landing_zone_destroy" {
  depends_on = [null_resource.landing_zone_apply]

  triggers = {
    components = "any component (or all components)"
  }

  provisioner "local-exec" {
    when    = create
    command = "echo 'info: apply ignored because part of destroy'"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "node ${path.module}/scripts/destroy.js"

    environment = {
      ROOT_PATH  = var.root_path
      COMPONENTS = jsonencode(var.landing_zone_components)
    }
  }
}
