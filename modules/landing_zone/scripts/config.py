import os
import json
from libs import execWithErrors, execWithoutErrors

def main():
    components = eval(os.environ['components'])
    aliases    = eval(os.environ['aliases'])

    processes = []
    default_processes = ['terrahub', 'configure', '-c']
    index = 1
    for (k, v) in aliases.items():
        if k != 'default':
            index += 1
            default = 'template.provider[' + str(index) + ']'
            processes.append(default_processes + [default +'={}'])
            processes.append(default_processes + [default +'.aws={}'])
            processes.append(default_processes + [default + '.aws.alias=' + k])
            processes.append(default_processes + [default + '.aws.region=${var.'+ k + '_region}'])
            processes.append(default_processes + [default + '.aws.assume_role[0]={}'])
            config = '\'arn:aws:iam::${var.' + k + '_account_id}:role/OrganizationAccountAccessRole\''
            processes.append(default_processes + [default + '.aws.assume_role[0].role_arn=' + config])
            processes.append(default_processes + [default + '.aws.assume_role[0].session_name=${var.' + k + '_account_id}'])
        for (key_sub, val_sub) in v.items():
            if k == 'default':
                processes.append(default_processes + ['template.tfvars.' + key_sub + '=' + val_sub])
            else:
                processes.append(default_processes + ['template.tfvars.'+ k + '_' + key_sub + '=' + val_sub])

    for (k, v) in components.items():
        execWithoutErrors(default_processes + ['terraform', '-D', '-y', '-i', k])
        processes.append(default_processes +['terraform.varFile[0]=' + str(v), '-i', k])
    execWithErrors(processes)
    return 'Success'

if __name__ == '__main__':
    RESP = main()
    print(RESP)
