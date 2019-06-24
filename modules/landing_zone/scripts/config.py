import os
import json
from libs import execWithErrors, execWithoutErrors

def main():
    processes = []
    providers = eval(os.environ['PROVIDERS'])
    components = eval(os.environ['COMPONENTS'])

    index = 1
    thub_cfg = ['terrahub', 'configure', '-c']
    for (k, v) in providers.items():
        if k != 'default':
            index += 1
            default = 'template.provider[' + str(index) + ']'
            processes.append(thub_cfg + [default + '={}'])
            processes.append(thub_cfg + [default + '.aws={}'])
            processes.append(thub_cfg + [default + '.aws.alias=' + k])
            processes.append(thub_cfg + [default + '.aws.region=${var.'+ k + '_region}'])
            processes.append(thub_cfg + [default + '.aws.assume_role[0]={}'])
            role_arn = '\'arn:aws:iam::${var.' + k + '_account_id}:role/OrganizationAccountAccessRole\''
            processes.append(thub_cfg + [default + '.aws.assume_role[0].role_arn=' + role_arn])
            processes.append(thub_cfg + [default + '.aws.assume_role[0].session_name=${var.' + k + '_account_id}'])
        for (key_sub, val_sub) in v.items():
            if k == 'default':
                processes.append(thub_cfg + ['template.tfvars.' + key_sub + '=' + val_sub])
            else:
                processes.append(thub_cfg + ['template.tfvars.'+ k + '_' + key_sub + '=' + val_sub])

    for (k, v) in components.items():
        execWithoutErrors(thub_cfg + ['terraform', '-D', '-y', '-i', k], os.environ['ROOT_PATH'])
        processes.append(thub_cfg +['terraform.varFile[0]=' + str(v), '-i', k])
    execWithErrors(processes, os.environ['ROOT_PATH'])
    return 'Success'

if __name__ == '__main__':
    RESP = main()
    print(RESP)
