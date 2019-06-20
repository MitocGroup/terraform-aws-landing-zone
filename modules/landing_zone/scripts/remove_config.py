import os
import json
from libs import execWithoutErrors

def main():
    components = eval(os.environ['components'])
    thub_cfg = ['terrahub', 'configure', '-c']

    execWithoutErrors(thub_cfg + ['template.tfvars', '-D', '-y'])
    execWithoutErrors(thub_cfg + ['template.provider', '-D', '-y'])
    execWithoutErrors(thub_cfg + ['template.provider[0]={}'])
    execWithoutErrors(thub_cfg + ['template.provider[0].aws={}'])
    execWithoutErrors(thub_cfg + ['template.provider[0].aws.region=${var.region}'])
    execWithoutErrors(thub_cfg + ['template.provider[0].aws.allowed_account_ids[]=${var.account_id}'])
    execWithoutErrors(thub_cfg + ['template.provider[1]={}'])
    execWithoutErrors(thub_cfg + ['template.provider[1].aws={}'])
    execWithoutErrors(thub_cfg + ['template.provider[1].aws.alias=default'])
    execWithoutErrors(thub_cfg + ['template.provider[1].aws.region=${var.region}'])
    execWithoutErrors(thub_cfg + ['template.provider[1].aws.allowed_account_ids[]=${var.account_id}'])
    execWithoutErrors(thub_cfg + ['template.tfvars.tfstate_path='
        + '/tmp/.terrahub/tfstate_local/terraform-aws-landing-zone'])
    
    for (k, v) in components.items():
        execWithoutErrors(thub_cfg + ['terraform', '-i', k, '-D', '-y'])
    return 'Success'

if __name__ == '__main__':
    RESP = main()
    print(RESP)
