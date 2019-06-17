import os
import json
import subprocess

def main():
    components = eval(os.environ['components'])
    processes = []
    processes.append(['terrahub', 'configure', '-c', 'template.tfvars.region=' + os.environ['region']])
    processes.append(['terrahub', 'configure', '-c', 'template.tfvars.account_id=' + os.environ['account_id']])

    for (k, v) in components.items():
        execWithoutErrors(['terrahub', 'configure', '-i', k, '-c', 'terraform', '-D', '-y'])
        processes.append(['terrahub', 'configure', '-i', k, '-c', 'terraform.varFile[0]=' + str(v)])
    execWithErrors(processes)
    return 'Success'

def execWithErrors(args_list):
    for args in args_list:
        p = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=os.environ['root'])
        (result, error) = p.communicate()
        if p.wait() != 0:
            print("Error: failed to execute command:")
            raise Exception(error)

def execWithoutErrors(args_list):
    p = subprocess.Popen(args_list, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=os.environ['root'])
    (result, error) = p.communicate()
    if p.wait() != 0:
        print("Error: failed to execute command:")
        print(error)

if __name__ == '__main__':
    RESP = main()
    print(RESP)
