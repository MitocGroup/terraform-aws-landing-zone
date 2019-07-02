# Steps

1. Setup access credentials to your AWS Organization account
2. Download `tfvars` files from `s3://terraform-aws-landing-zone/mycompany/`
    * Possible to use from local disk (e.g. `./tfvars/` folder)
3. Update `account_id` and `region` in `terraform.tfvars`
    * aws sts get-caller-identity --output=text --query='Account'
4. Remove from `outputs.tf` and `terraform.tfvars` unused configs
5. rm -rf .terraform terraform.tfstate* /tmp/.terrahub/tfstate_local/terraform-aws-landing-zone
5. ~/.terrahub/terraform/0.11.11/terraform init
6. ~/.terrahub/terraform/0.11.11/terraform apply -target module.landing_zone.null_resource.landing_zone_config
    * For now, comment out `apply.py` and `destroy.py`
7. Import resources using below commands
8. `~/.terrahub/terraform/0.11.11/terraform apply`
9. Go to `./demo/` folder and run terraform workflow


## Import

terrahub import -i landing_zone_vpc -c aws_vpc.landing_zone_vpc=vpc-616e1318 \
  && terrahub refresh -i landing_zone_vpc \
  && terrahub import -i landing_zone_subnet -c aws_subnet.landing_zone_subnet[0]=subnet-ada0c7f7 \
  && terrahub import -i landing_zone_subnet -c aws_subnet.landing_zone_subnet[1]=subnet-b3640b9f \
  && terrahub refresh -i landing_zone_subnet \
  && terrahub import -i landing_zone_route_table -c aws_route_table.landing_zone_route_table=rtb-56a3ad2e \
  && terrahub refresh -i landing_zone_route_table

### landing_zone_route_table_association nu poate fi importat

terrahub import -i landing_zone_gateway_igw -c aws_internet_gateway.landing_zone_gateway_igw=igw-0baf896d \
  && terrahub refresh -i landing_zone_gateway_igw \
  && terrahub import -i landing_zone_route_igw -c aws_route.landing_zone_route_igw=rtb-56a3ad2e_0.0.0.0/0 \
  && terrahub refresh -i landing_zone_route_igw \
  && terrahub import -i landing_zone_route -c aws_route.landing_zone_route=rtb-56a3ad2e_172.16.0.0/16 \
  && terrahub refresh -i landing_zone_route \
  && terrahub import -i landing_zone_network_acl -c aws_network_acl.landing_zone_network_acl=acl-f77b9a8f \
  && terrahub refresh -i landing_zone_network_acl

### landing_zone_network_acl_rules nu poate fi importats

terrahub import -i landing_zone_security_group -c aws_security_group.landing_zone_security_group=sg-bc5b47cd
  cd ~/.terrahub/cache/jit/landing_zone_security_group_eef16dcf/
  ~/.terrahub/terraform/0.11.11/terraform init -var-file=default.tfvars -var-file=config.tfvars
  ~/.terrahub/terraform/0.11.11/terraform plan -var-file=default.tfvars -var-file=config.tfvars
  ~/.terrahub/terraform/0.11.11/terraform state rm aws_security_group_rule.landing_zone_security_group
  ~/.terrahub/terraform/0.11.11/terraform state rm aws_security_group_rule.landing_zone_security_group-1
  ~/.terrahub/terraform/0.11.11/terraform plan -var-file=default.tfvars -var-file=config.tfvars
#### cd back into terraform-aws-landing-zone repository
terrahub refresh -i landing_zone_security_group \
  && terrahub import -i landing_zone_security_group_rule_ingress -c aws_security_group_rule.landing_zone_security_group_rule_ingress=sg-bc5b47cd_ingress_all_0_65536_sg-bc5b47cd \
  && terrahub refresh -i landing_zone_security_group_rule_ingress \
  && terrahub import -i landing_zone_security_group_rule_egress -c aws_security_group_rule.landing_zone_security_group_rule_egress=sg-bc5b47cd_egress_all_0_0_0.0.0.0/0 \
  && terrahub refresh -i landing_zone_security_group_rule_egress

terrahub import -i landing_zone_cloudtrail_s3_bucket -c aws_s3_bucket.landing_zone_cloudtrail_s3_bucket=data-lake-cloudtrail-us-east-1
  cd ~/.terrahub/cache/jit/landing_zone_cloudtrail_s3_bucket_eef16dcf/
  ~/.terrahub/terraform/0.11.11/terraform init -var-file=default.tfvars -var-file=config.tfvars
  ~/.terrahub/terraform/0.11.11/terraform plan -var-file=default.tfvars -var-file=config.tfvars
  ~/.terrahub/terraform/0.11.11/terraform state rm aws_s3_bucket_policy.landing_zone_cloudtrail_s3_bucket
  ~/.terrahub/terraform/0.11.11/terraform plan -var-file=default.tfvars -var-file=config.tfvars
#### cd back into terraform-aws-landing-zone repository
terrahub refresh -i landing_zone_cloudtrail_s3_bucket \
  && terrahub import -i landing_zone_cloudtrail_s3_bucket_policy -c aws_s3_bucket_policy.landing_zone_cloudtrail_s3_bucket_policy=data-lake-cloudtrail-us-east-1 \
  && terrahub refresh -i landing_zone_cloudtrail_s3_bucket_policy \
  && terrahub import -i landing_zone_cloudtrail -c aws_cloudtrail.landing_zone_cloudtrail=Default \
  && terrahub refresh -i landing_zone_cloudtrail \
  && terrahub import -i landing_zone_directory_service_directory -c aws_directory_service_directory.landing_zone_directory_service_directory=d-90672aecce \
  && terrahub refresh -i landing_zone_directory_service_directory
