# landing_zone_reader
[AWS Landing Zone](https://aws.amazon.com/solutions/aws-landing-zone/) is
a solution that helps customers more quickly set up a secure, multi-account
AWS environment based on AWS best practices. This repository contains terraform
module `landing_zone` that dynamically deploys components of AWS Landing Zone
solution based on input list of `.tfvars` files.

Additionally, there are 2 more terraform modules: `landing_zone_reader_config`
and `landing_zone_reader`. They allow AWS Landing Zone consumers to reuse
terraform outputs programmatically. This way administrators of AWS Landing Zone
control who can manage `landing_zone` module and who can consume `landing_zone`
module's outputs in read-only mode.

> NOTE: Current implementation is fully compatible with terraform v0.12+.
Switch to branch `v0.11` if you still using terraform v0.11.x and below.


## Usage Example
To get started, simply include the following terraform codebase:
```hcl
module "landing_zone" {
  source  = "./modules/landing_zone_reader"
  version = "0.1.0"
}
```

> NOTE: Before using this module, make sure that `landing_zone_reader_config` module
is executed first!

## More Examples
* [Terraform module for AWS Lambda function using AWS Landing Zone reader](https://github.com/TerraHubCorp/terraform-aws-landing-zone/tree/master/examples/example_landing_zone_reader)


## Why to Use This Solution

### No need for code changes
Terraform module for AWS Landing Zone solution is up to 10 lines of code that receives a list of `.tfvars` files as input variables which describe providers (to be read: AWS accounts and AWS regions) and configs (to be read: AWS resources)

### No need for code rewrites
This implementation engages microservices architecture, allowing any component to be replaced with another component (or multiple components)

### No need for hard-coded values
Existing AWS resources created by your team can be reused programmatically as read only values by other teams' terraform configurations

### No need to rebuild from scratch
Existing AWS resources in your current AWS account(s) can be imported and reused without downtime by this terraform module via `terraform import` command

### No need to exclude pieces of account(s) baseline
Some customers were avoiding in the past AWS Landing Zone because it doesn't support some kind of 3rd party SSO solution or 3rd party Logging solution. By using terraform, we can easily bring those solutions into AWS Landing Zone as a set of components and empower customers to continue using best practices of both worlds

### Additionally, this module helps enforce best practices
- By removing the need for access to AWS root account(s)
- By using IAM cross-account roles and/or STS temporary credentials
- By enabling centralized CloudTrail logs and cross-region replication of CloudTrail logs
- By empowering complex organizations to separate roles and responsibilities (e.g. InfoSec team can place explicit deny on IAM, VPC, SG and STS for other teams and/or other environments like production or pre-production)
