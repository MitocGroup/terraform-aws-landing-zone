import os
import json
import subprocess

def main():
    components = eval(os.environ['components'])
    processes = []

    include = []
    for (k, v) in components.items():
        include.append(k)
        execWithoutErrors(['terrahub', 'configure', '-i', k, '-c', 'terraform', '-D', '-y'])
        processes.append(['terrahub', 'configure', '-i', k, '-c', "terraform.varFile[0]=" + str(v)])
    include = ','.join(include)
    processes.append(['terrahub', 'init', '-i', include])
    processes.append(['terrahub', os.environ['command'], '-i', include, '-y'])
    processes.append(['terrahub', 'output', '-o', 'json', '-i', include, '-y'])
    return terrahubOutput(exec(processes))

def terrahubOutput(result):
    response = {}

    for (key, val) in json.loads(result).items():
        for (key_sub, val_sub) in val.items():
            response[key_sub]=val_sub['value']

    output_file_path = os.path.join(os.environ['root'], 'output.json')
    open(output_file_path, 'a').close()
    with open(output_file_path, 'wb') as json_file:
        json_file.write(json.dumps(response).encode("utf-8"))

    return 'Success'

def exec(args_list):
    result = ''
    for args in args_list:
        p = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=os.environ['root'])
        (result, error) = p.communicate()
        if p.wait() != 0:
            print("Error: failed to execute command:")
            raise Exception(error)

    return result


def execWithoutErrors(args):
    p = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=os.environ['root'])
    (result, error) = p.communicate()
    if p.wait() != 0:
        print("Error: failed to execute command:")
        print(error)

if __name__ == '__main__':
    RESP = main()
    print(RESP)
