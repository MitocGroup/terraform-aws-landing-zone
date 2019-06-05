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
module "sample" {
  source     = "TerraHubCorp/landing-zone/aws"
  version    = "0.0.1"
  root_path  = "${path.module}"
  account_id = "${var.account_id}"
  region     = "${var.region}"
  landing_zone_components = "${var.landing_zone_components}"
}
```
> NOTE: Make sure to include `variables.tf` and whatever makes sense from `outputs.tf`


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

### Multi-Account Structure
This terraform module at this point in time covers only Multi-Account Structure:
![AWS Landing Zone Architecture](https://github.com/TerraHubCorp/terraform-aws-landing-zone/raw/master/docs/aws-landing-zone-architecture.png)

Based on above architecture, the list of available components is:
* Two Amazon S3 buckets for [manifest files](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_pipeline_s3_bucket/.terrahub.yml#L12) and [artifacts](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_pipeline_artifact_s3_bucket/.terrahub.yml#L12)
* AWS CodePipeline [configuration](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_code_pipeline/.terrahub.yml#L39) for continuous delivery
* AWS CodeBuild [configuration](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_code_build/.terrahub.yml#L27) for building artifacts
* AWS Organization [account](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_organization/.terrahub.yml#L12) and [multi-accounts setup](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/components/landing_zone_organization_accounts/.terrahub.yml#L21)

### Account Vending Machine
Coming soon...

![AWS Landing Zone Architecture](https://github.com/TerraHubCorp/terraform-aws-landing-zone/raw/master/docs/aws-landing-zone-account-vending-machine.png)

### User Access and Identity Management
Coming soon...

![AWS Landing Zone Architecture](https://github.com/TerraHubCorp/terraform-aws-landing-zone/raw/master/docs/aws-landing-zone-user-access.png)

### Monitoring and Notifications
Coming soon...

![AWS Landing Zone Architecture](https://github.com/TerraHubCorp/terraform-aws-landing-zone/raw/master/docs/aws-landing-zone-notifications.png)
