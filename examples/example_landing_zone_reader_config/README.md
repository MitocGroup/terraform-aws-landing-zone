# example_landing_zone_reader_config
This example implements fully functional terraform configuration that can programmatically retrieve resources' output parameters created (or updated) by `landing_zone` module.

## Example Usage

This module can be used as easy as:
```hcl
module "example_landing_zone_reader_config" {
  source    = "../../modules/landing_zone_reader_config"
  version   = "0.0.7"
  root_path = "${path.cwd}/../.."

  landing_zone_providers  = "${var.landing_zone_providers}"
  landing_zone_components = "${var.landing_zone_components}"
}
```

## Input / Arguments Reference
The following arguments / input parameters are expected by `landing_zone_reader_config` module:

Name | Required? | Description
-----|-----------|------------
source | Required | All modules require a source argument, which is a meta-argument defined by Terraform CLI. Its value is either the path to a local directory of the module's configuration files, or a remote module source that Terraform should download and use. This value must be a literal string with no template sequences; interpolations are not allowed.
version | Optional | A version constraint string that specifies which versions of the referenced module are acceptable. The newest version matching the constraint will be used. version is supported only for modules retrieved from module registries.
providers | Optional | A map whose keys are provider configuration names that are expected by child module and whose values are corresponding provider names in the calling module. This allows provider configurations to be passed explicitly to child modules. If not specified, the child module inherits all of the default (un-aliased) provider configurations from the calling module.
root_path | Required | The path to module's root. In general, you probably want to pass the `path.module` variable, which will interpolate the path to the current module.
landing_zone_providers | Required | The map of providers. Each provider must specify `account_id` and `region` corresponding to AWS account and AWS region where resources will be deployed.
landing_zone_components | Required | The map of components. Each component must specify the component name as key and the path to component's `tfvars` file that describes resource(s) configurations.

## Output / Attributes Reference
The following attributes / output parameters are produced by `landing_zone_reader_config` module:

Name | Description
-----|------------
landing_zone_reader | This map ( to be exact: map(map(map(any))) ) consolidates all outputs for each AWS resource created (or updated) in each AWS account (defined by `provider`) for each landing zone component (defined by `landing_zone_components`)
