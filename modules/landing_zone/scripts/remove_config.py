import os
import json
from libs import execWithoutErrors

def main():
    components = eval(os.environ['components'])
    execWithoutErrors(['terrahub', 'configure', '-c', 'template.tfvars', '-D', '-y'])
    execWithoutErrors(['terrahub', 'configure', '-c', 'template.provider', '-D', '-y'])
    execWithoutErrors(['terrahub', 'configure', '-c', 'template.provider[0]={}'])
    execWithoutErrors(['terrahub', 'configure', '-c', 'template.provider[0].aws={}'])
    execWithoutErrors(['terrahub', 'configure', '-c',
        'template.provider[0].aws.region=${var.region}'])
    execWithoutErrors(['terrahub', 'configure', '-c',
        'template.provider[0].aws.allowed_account_ids[]=${var.account_id}'])
    execWithoutErrors(['terrahub', 'configure', '-c', 'template.provider[1]={}'])
    execWithoutErrors(['terrahub', 'configure', '-c', 'template.provider[1].aws={}'])
    execWithoutErrors(['terrahub', 'configure', '-c', 'template.provider[1].aws.alias=default'])
    execWithoutErrors(['terrahub', 'configure', '-c',
        'template.provider[1].aws.region=${var.region}'])
    execWithoutErrors(['terrahub', 'configure', '-c',
        'template.provider[1].aws.allowed_account_ids[]=${var.account_id}'])
    execWithoutErrors(['terrahub', 'configure', '-c',
        'template.tfvars.tfstate_path=/tmp/.terrahub/tfstate_local/terraform-aws-landing-zone'])
    
    for (k, v) in components.items():
        execWithoutErrors(['terrahub', 'configure', '-i', k, '-c', 'terraform', '-D', '-y'])
    return 'Success'

if __name__ == '__main__':
    RESP = main()
    print(RESP)
