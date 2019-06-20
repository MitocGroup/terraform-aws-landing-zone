import os
import json
from libs import execWithoutErrors

def main():
    components = eval(os.environ['components'])
    thub_cfg = ['terrahub', 'configure', '-c']

    execWithoutErrors(thub_cfg + ['template.tfvars', '-D', '-y'], os.environ['root'])
    execWithoutErrors(thub_cfg + ['template.provider', '-D', '-y'], os.environ['root'])
    execWithoutErrors(thub_cfg + ['template.provider[0]={}'], os.environ['root'])
    execWithoutErrors(thub_cfg + ['template.provider[0].aws={}'], os.environ['root'])
    execWithoutErrors(thub_cfg + ['template.provider[0].aws.region=${var.region}'], os.environ['root'])
    execWithoutErrors(thub_cfg + ['template.provider[0].aws.allowed_account_ids[]=${var.account_id}'], os.environ['root'])
    execWithoutErrors(thub_cfg + ['template.provider[1]={}'], os.environ['root'])
    execWithoutErrors(thub_cfg + ['template.provider[1].aws={}'], os.environ['root'])
    execWithoutErrors(thub_cfg + ['template.provider[1].aws.alias=default'], os.environ['root'])
    execWithoutErrors(thub_cfg + ['template.provider[1].aws.region=${var.region}'], os.environ['root'])
    execWithoutErrors(thub_cfg + ['template.provider[1].aws.allowed_account_ids[]=${var.account_id}'], os.environ['root'])
    execWithoutErrors(thub_cfg + ['template.tfvars.account_id=123456789012'], os.environ['root'])
    execWithoutErrors(thub_cfg + ['template.tfvars.region=us-east-1'], os.environ['root'])
    execWithoutErrors(thub_cfg + ['template.tfvars.tfstate_path='
        + '/tmp/.terrahub/tfstate_local/terraform-aws-landing-zone'], os.environ['root'])
    
    for (k, v) in components.items():
        execWithoutErrors(thub_cfg + ['terraform', '-i', k, '-D', '-y'], os.environ['root'])
    return 'Success'

if __name__ == '__main__':
    RESP = main()
    print(RESP)
