resource "null_resource" "terraform_config" {
  provisioner "local-exec" {
    command = var.terraform_config ? "mv .terrahub.yml.backup .terrahub.yml" : "echo 'Terraform config is ignore!'"
  }
}

resource "null_resource" "landing_zone_reader_config" {
  depends_on = [null_resource.terraform_config]

  triggers = {
    providers  = md5(jsonencode(var.landing_zone_providers))
    components = md5(jsonencode(var.landing_zone_components))
    backend    = md5(jsonencode(var.terraform_backend))
  }

  provisioner "local-exec" {
    when    = create
    command = "node ${path.module}/scripts/config.js"

    environment = {
      ROOT_PATH  = var.root_path
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

resource "null_resource" "landing_zone_reader_apply" {
  depends_on = [null_resource.landing_zone_reader_config]

  triggers = {
    components = md5(jsonencode(var.landing_zone_components))
    backend    = md5(jsonencode(var.terraform_backend))
    timestamp  = timestamp()
  }

  provisioner "local-exec" {
    when    = create
    command = "node ${path.module}/scripts/apply.js"

    environment = {
      ROOT_PATH  = var.root_path
      COMPONENTS = jsonencode(var.landing_zone_components)
      BACKEND    = jsonencode(var.terraform_backend)
    }
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'info: destroy ignored because part of apply'"
  }
}
