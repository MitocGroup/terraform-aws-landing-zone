import os
import json
from libs import execWithoutErrors

def main():
    root_path = os.environ['ROOT_PATH']
    components = eval(os.environ['COMPONENTS'])
    thub_cfg = ['terrahub', 'configure', '-c']

    execWithoutErrors(thub_cfg + ['template.tfvars', '-D', '-y'], root_path)
    execWithoutErrors(thub_cfg + ['template.provider', '-D', '-y'], root_path)
    execWithoutErrors(thub_cfg + ['template.provider[0]={}'], root_path)
    execWithoutErrors(thub_cfg + ['template.provider[0].aws={}'], root_path)
    execWithoutErrors(thub_cfg + ['template.provider[0].aws.region=${var.region}'], root_path)
    execWithoutErrors(thub_cfg + ['template.provider[0].aws.allowed_account_ids[]=${var.account_id}'], root_path)
    execWithoutErrors(thub_cfg + ['template.provider[1]={}'], root_path)
    execWithoutErrors(thub_cfg + ['template.provider[1].aws={}'], root_path)
    execWithoutErrors(thub_cfg + ['template.provider[1].aws.alias=default'], root_path)
    execWithoutErrors(thub_cfg + ['template.provider[1].aws.region=${var.region}'], root_path)
    execWithoutErrors(thub_cfg + ['template.provider[1].aws.allowed_account_ids[]=${var.account_id}'], root_path)
    execWithoutErrors(thub_cfg + ['template.tfvars.account_id=123456789012'], root_path)
    execWithoutErrors(thub_cfg + ['template.tfvars.region=us-east-1'], root_path)
    execWithoutErrors(thub_cfg + ['template.tfvars.tfstate_path='
        + '/tmp/.terrahub/tfstate_local/terraform-aws-landing-zone'], root_path)
    
    for (k, v) in components.items():
        execWithoutErrors(thub_cfg + ['terraform', '-i', k, '-D', '-y'], root_path)
    return 'Success'

if __name__ == '__main__':
    RESP = main()
    print(RESP)
