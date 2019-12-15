# Steps

1. Setup access credentials to your AWS Organization account
2. Download `tfvars` files from `s3://terraform-aws-landing-zone/components/`
    * Possible to use from local disk (e.g. `./tfvars/` folder)
3. Update `account_id` and `region` in `terraform.tfvars`
    * aws sts get-caller-identity --output=text --query='Account'
4. Remove from `outputs.tf` and `terraform.tfvars` unused configs
5. rm -rf .terraform terraform.tfstate* /tmp/.terrahub/landing_zone ~/.terrahub/cache/hcl
6. terraform init
7. terraform apply -target module.landing_zone.null_resource.landing_zone_config
8. terrahub import --batch default.tfimport
9. terraform apply
10. Go to `./examples/` folders and run terraform workflow for each example
11. aws lambda invoke --function-name my_hello_world hello_world.txt
