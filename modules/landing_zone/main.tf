resource "null_resource" "terraform_config" {
  triggers = {
    config = var.terraform_config
    backup = ".terrahub.yml.backup"
    new    = ".terrahub.yml"
  }

  provisioner "local-exec" {
    when    = create
    command = self.triggers.config ? "mv ${self.triggers.backup} ${self.triggers.new}" : "echo 'Terraform config is ignore!'"
  }
}

resource "null_resource" "landing_zone_config" {
  depends_on = [null_resource.terraform_config]

  triggers = {
    command     = var.terraform_command
    providers   = jsonencode(var.landing_zone_providers)
    components  = jsonencode(var.landing_zone_components)
    backend     = jsonencode(var.terraform_backend)
    module_path = path.module
    root_path   = var.root_path
  }

  provisioner "local-exec" {
    when    = create
    command = <<-EOC
      node ${self.triggers.module_path}/scripts/config.js
    EOC

    environment = {
      ROOT_PATH  = self.triggers.root_path
      COMMAND    = self.triggers.command
      PROVIDERS  = self.triggers.providers
      COMPONENTS = self.triggers.components
      BACKEND    = self.triggers.backend
    }
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOD
      node ${self.triggers.module_path}/scripts/remove-config.js
    EOD

    environment = {
      ROOT_PATH  = self.triggers.root_path
      COMPONENTS = self.triggers.components
    }
  }
}

resource "null_resource" "landing_zone_apply" {
  depends_on = [null_resource.landing_zone_config]

  triggers = {
    command    = var.terraform_command
    components = jsonencode(var.landing_zone_components)
    timestamp  = timestamp()
    module_path = path.module
    root_path   = var.root_path
    output_path = pathexpand("~/.terrahub/cache/landing_zone/output.json")
  }

  provisioner "local-exec" {
    when    = create
    command = <<-EOC
      node ${self.triggers.module_path}/scripts/apply.js
    EOC

    environment = {
      OUTPUT_PATH = self.triggers.output_path
      ROOT_PATH   = self.triggers.root_path
      COMMAND     = self.triggers.command
      COMPONENTS  = self.triggers.components
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
    components  = jsonencode(var.landing_zone_components)
    module_path = path.module
    root_path   = var.root_path
  }

  provisioner "local-exec" {
    when    = create
    command = "echo 'info: apply ignored because part of destroy'"
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOD
      node ${self.triggers.module_path}/scripts/destroy.js
    EOD

    environment = {
      ROOT_PATH  = self.triggers.root_path
      COMPONENTS = self.triggers.components
    }
  }
}
