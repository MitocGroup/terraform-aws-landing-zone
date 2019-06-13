import os
import json
import subprocess

def main():
    components = eval(os.environ['components'])
    processes = []
    
    include = []
    for (k, v) in components.items():
        include.append(k)
    includeStr = ','.join(include)
    processes.append(['terrahub', 'init', '-i', includeStr])
    processes.append(['terrahub', os.environ['command'], '-i', includeStr, '-y'])
    execWithErrors(processes)
    return terrahubOutput(include)

def terrahubOutput(include):
    response = {}

    for innclude_item in include:
        result = ''
        p = subprocess.Popen(
            ['terrahub', 'output', '-o', 'json', '-i', innclude_item, '-y'],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            cwd=os.environ['root'])
        (result, error) = p.communicate()
        if p.wait() == 0:
            response.update(extractOutputValues(result))

    output_file_path = os.path.join(os.environ['root'], 'output.json')
    open(output_file_path, 'a').close()
    with open(output_file_path, 'wb') as json_file:
        json_file.write(json.dumps(response).encode("utf-8"))

    return 'Success'

def extractOutputValues(result):
    response = {}
    for (key, val) in json.loads(result).items():
        try:
            for (key_sub, val_sub) in val.items():
                response[key_sub]=getOutputValueByType(val_sub['value'])
        except:
            print('This key: ' + key + ' dose not have values.')
    
    return response

def getOutputValueByType(value):
    if type(value) is unicode:
        return value
    else:
        return ','.join(map(str, value))

def execWithErrors(args_list):
    for args in args_list:
        p = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=os.environ['root'])
        (result, error) = p.communicate()
        if p.wait() != 0:
            print("Error: failed to execute command:")
            raise Exception(error)

if __name__ == '__main__':
    RESP = main()
    print(RESP)
