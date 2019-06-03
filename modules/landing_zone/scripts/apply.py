import os
import json
import subprocess

def main():
    components = eval(os.environ['components'])
    include = []
    for (k, v) in components.items():
        include.append(k)
        args_add_delete = ['terrahub', 'configure', '-i', k, '-c', 'terraform', '-D', '-y']
        process = subprocess.Popen(args_add_delete, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=os.environ['root'])
        (result, error) = process.communicate()
        rc = process.wait()
        args_add_config = ['terrahub', 'configure', '-i', k, '-c', "terraform.varFile[0]=" + str(v)]
        subprocess.Popen(args_add_config, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=os.environ['root'])
    include = ','.join(include)
    if terrahubInit(include):
        if terrahubRun(include):
            return terrahubOutput(include)


def terrahubInit(include):
    args_init = ['terrahub', 'init', '-i', include]
    process_init = subprocess.Popen(args_init, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=os.environ['root'])
    (result, error) = process_init.communicate()

    rc = process_init.wait()

    if rc != 0:
        print("Error: failed to execute command:")
        raise Exception(error)
    
    return True

def terrahubRun(include):    
    args_run = ['terrahub', os.environ['command'], '-i', include, '-a', '-y']
    process_run = subprocess.Popen(args_run, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=os.environ['root'])
    (result, error) = process_run.communicate()

    rc = process_run.wait()

    if rc != 0:
        print("Error: failed to execute command:")
        raise Exception(error)
    
    return True

def terrahubOutput(include):
    args_output = ['terrahub', 'output', '-o', 'json', '-i', include, '-y']
    process_output = subprocess.Popen(args_output, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=os.environ['root'])
    (result, error) = process_output.communicate()

    rc = process_output.wait()

    if rc != 0:
        print("Error: failed to execute command:")
        raise Exception(error)    
    
    response = {}
    for (key, val) in json.loads(result).items():
    	for (key_sub, val_sub) in val.items():
            response[key_sub]=val_sub['value']

    with open(os.path.join(os.environ['root'], 'output.json'), 'wb') as json_file:
        json_file.write(json.dumps(response).encode("utf-8"))

    return 'Success'

if __name__ == '__main__':
    RESP = main()
    print(RESP)
