import os
import json
import subprocess

def main():
    components = eval(os.environ['components'])

    include = []
    for (k, v) in components.items():
        include.append(k)
    include = ','.join(include)
    args = ['terrahub', 'destroy', '-i', include, '-y', '-p', 'ignore']
    p = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=os.environ['root'])
    (result, error) = p.communicate()
    if p.wait() != 0:
        print("Error: failed to execute command:")
        raise Exception(error)

    return 'Success'

if __name__ == '__main__':
    RESP = main()
    print(RESP)
