import os
import json
from libs import execWithErrors, execWithoutErrors

def main():
    components = eval(os.environ['components'])
    aliases    = eval(os.environ['aliases'])

    config_processes = []
    index = 1
    for (k, v) in aliases.items():
        if k != 'default':
            index += 1
            default = 'template.provider[' + str(index) + ']'
            config_processes.append(['terrahub', 'configure', '-c',
                default +'={}'])
            config_processes.append(['terrahub', 'configure', '-c',
                default +'.aws={}'])
            config_processes.append(['terrahub', 'configure', '-c',
                default + '.aws.alias=' + k])
            config_processes.append(['terrahub', 'configure', '-c',
                default + '.aws.region=${var.'+ k + '_region}'])
            config_processes.append(['terrahub', 'configure', '-c',
                default + '.aws.assume_role[0]={}'])
            config = '\'arn:aws:iam::${var.' + k + '_account_id}:role/OrganizationAccountAccessRole\''
            config_processes.append(['terrahub', 'configure', '-c',
                default + '.aws.assume_role[0].role_arn=' + config])
            config_processes.append(['terrahub', 'configure', '-c',
                default + '.aws.assume_role[0].session_name=${var.' + k + '_account_id}'])
        for (key_sub, val_sub) in v.items():
            if k == 'default':
                config_processes.append(['terrahub', 'configure', '-c',
                    'template.tfvars.' + key_sub + '=' + val_sub])
            else:
                config_processes.append(['terrahub', 'configure', '-c',
                    'template.tfvars.'+ k + '_' + key_sub + '=' + val_sub])

    for (k, v) in components.items():
        execWithoutErrors(['terrahub', 'configure', '-i', k, '-c', 'terraform', '-D', '-y'])
        config_processes.append(['terrahub', 'configure', '-i', k, '-c', 'terraform.varFile[0]=' + str(v)])
    execWithErrors(config_processes)
    return 'Success'

if __name__ == '__main__':
    RESP = main()
    print(RESP)
