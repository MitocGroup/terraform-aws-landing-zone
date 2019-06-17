import os
import json
import subprocess

def main():
    components = eval(os.environ['components'])
    execWithoutErrors(['terrahub', 'configure', '-c', 'template.tfvars', '-D', '-y'])
    
    for (k, v) in components.items():
        execWithoutErrors(['terrahub', 'configure', '-i', k, '-c', 'terraform', '-D', '-y'])
    return 'Success'

def execWithoutErrors(args_list):
    p = subprocess.Popen(args_list, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=os.environ['root'])
    (result, error) = p.communicate()
    if p.wait() != 0:
        print("Error: failed to execute command:")
        print(error)

if __name__ == '__main__':
    RESP = main()
    print(RESP)
