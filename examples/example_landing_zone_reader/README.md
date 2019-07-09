# example_landing_zone_reader
This example implements fully functional terraform configuration that can programmatically retrive resources' output parameters created (or updated) by `landing_zone` module.

## Example Usage

This module can be used as easy as:
```hcl
module "example_landing_zone_reader" {
  source  = "../../modules/landing_zone_reader"
  version = "0.0.7"
}
```

## Input / Arguments Reference
The following arguments / input parameters are expected by `landing_zone_reader` module:

Name | Required? | Description
-----|-----------|------------
source | Required | All modules require a source argument, which is a meta-argument defined by Terraform CLI. Its value is either the path to a local directory of the module's configuration files, or a remote module source that Terraform should download and use. This value must be a literal string with no template sequences; interpolations are not allowed.
version | Optional | A version constraint string that specifies which versions of the referenced module are acceptable. The newest version matching the constraint will be used. version is supported only for modules retrieved from module registries.
providers | Optional | A map whose keys are provider configuration names that are expected by child module and whose values are corresponding provider names in the calling module. This allows provider configurations to be passed explicitly to child modules. If not specified, the child module inherits all of the default (un-aliased) provider configurations from the calling module.

## Output / Attributes Reference
The following attributes / output parameters are produced by `landing_zone_reader` module:

Name | Description
-----|------------
landing_zone_reader | To be updated.
