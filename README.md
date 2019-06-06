# terraform-aws-landing-zone
[AWS Landing Zone](https://aws.amazon.com/solutions/aws-landing-zone/) is
a solution that helps customers more quickly set up a secure, multi-account
AWS environment based on AWS best practices. This repository contains one
terraform module that dynamically deploys components of AWS Landing Zone
solution based on input list of `.tfvars` files.


## How Does This Module Work
Based on terraform's [standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
guidelines, this repository contains the following folders:
* root folder - module's standard terraform configuration
* [components](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components) - yaml-based and terraform compatible configurations
* [examples](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/examples) - different ways to combine components as part of this module
* [modules](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/modules) - standalone, reusable and production-ready module
* [tests](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/tests) - set of automated tests to use in CI/CD pipelines

This terraform module requires the following dependencies:
* [python](https://www.python.org) - referenced and validated [here](./modules/landing_zone/scripts/apply.sh#L22)
* [terrahub](https://www.npmjs.com/package/terrahub) - referenced and validated [here](./modules/landing_zone/scripts/apply.sh#L21)

To get started, simply include `main.tf` into your terraform codebase:
```hcl
module "landing_zone" {
  source     = "TerraHubCorp/landing-zone/aws"
  version    = "0.0.3"
  root_path  = "${path.module}"
  account_id = "${var.account_id}"
  region     = "${var.region}"
  landing_zone_components = "${var.landing_zone_components}"
}
```
> NOTE: Make sure to include `variables.tf` and whatever makes sense from `outputs.tf`

To simplify and make it easier to understand, we included default values in `terraform.tfvars`:
```
account_id = "123456789012"
region = "us-east-1"
landing_zone_components = {
  landing_zone_pipeline_s3_bucket = "s3://terraform-aws-landing-zone/mycompany/landing_zone_pipeline_s3_bucket/default.tfvars"
  [...]
}

```

This means that when you use this terraform module, you will need to:
1. Change `account_id` and `region` to values that correspond to your AWS Organization
2. Change `landing_zone_components` to values that fit your AWS Landing Zone use case
    * each key from `landing_zone_components` map represents the name of the component from [here](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components)
    * each value from `landing_zone_components` map represents the path to `.tfvars` file on S3
3. Change `s3://terraform-aws-landing-zone/mycompany/` to your S3 bucket and S3 key prefix where you will be storing `.tfvars` files

> NOTE: This module can have tens, hundreds or thousands of components. At runtime, components that are not part of `landing_zone_components` map will be ignored.


## What Components Are Available
AWS Landing Zone solution is defined by the following strategy:
1. [Multi-Account Structure](#multi-account-structure)
    * AWS Organization Account
    * Shared Services Account
    * Log Archive Account
    * Security Account
2. [Account Vending Machine](#account-vending-machine)
3. [User Access and Identity Management](#user-access-and-identity-management)
4. [Monitoring and Notifications](#monitoring-and-notifications)

> NOTE: This terraform module at this point in time covers only Multi-Account Structure.

### Multi-Account Structure
<img align="right" src="https://github.com/TerraHubCorp/terraform-aws-landing-zone/raw/master/docs/aws-landing-zone-architecture.png" alt="AWS Landing Zone Multi-Account Architecture" />

Based on the multi-account architecture, here below are currently available components:
1. [landing_zone_pipeline_s3_bucket](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_pipeline_s3_bucket/.terrahub.yml#L11)
2. [landing_zone_pipeline_artifact_s3_bucket](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_pipeline_artifact_s3_bucket/.terrahub.yml#L11)
3. [landing_zone_code_pipeline](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_code_pipeline/.terrahub.yml#L34)
4. [landing_zone_code_pipeline_role](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_code_pipeline_role/.terrahub.yml#L11)
5. [landing_zone_code_pipeline_role_policy](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_code_pipeline_role_policy/.terrahub.yml#L41)
6. [landing_zone_code_build](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_code_build/.terrahub.yml#L24)
7. [landing_zone_code_build_role](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_code_build_role/.terrahub.yml#L11)
8. [landing_zone_code_build_role_policy](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_code_build_role_policy/.terrahub.yml#L31)
9. [landing_zone_organization](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_organization/.terrahub.yml#L11)
10. [landing_zone_organization_policy](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_organization_policy/.terrahub.yml#L11)
11. [landing_zone_organization_policy_attachment](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_organization_policy_attachment/.terrahub.yml#L21)
12. [landing_zone_organization_accounts](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_organization_accounts/.terrahub.yml#L19)
13. [landing_zone_organization_unit](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_organization_unit/.terrahub.yml#L19)

<br clear="right" />

### Account Vending Machine
<img align="right" src="https://github.com/TerraHubCorp/terraform-aws-landing-zone/raw/master/docs/aws-landing-zone-account-vending-machine.png" alt="AWS Landing Zone Account Vending Machine Architecture" />

Based on the account vending machine architecture, here below are currently available components:
1. Coming soon ...

<br clear="right" />

### User Access and Identity Management
<img align="right" src="https://github.com/TerraHubCorp/terraform-aws-landing-zone/raw/master/docs/aws-landing-zone-user-access.png" alt="AWS Landing Zone User Access and Identity Management Architecture" />

Based on the user access architecture, here below are currently available components:
1. Coming soon ...

<br clear="right" />

### Monitoring and Notifications
<img align="right" src="https://github.com/TerraHubCorp/terraform-aws-landing-zone/raw/master/docs/aws-landing-zone-notifications.png" alt="AWS Landing Zone Monitoring and Notifications Architecture" />

Based on the notifications architecture, here below are currently available components:
1. Coming soon ...

<br clear="right" />
