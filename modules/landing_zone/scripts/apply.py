import os
import json
from libs import cli, execWithErrors
from six import string_types

def main():
    processes = []
    components = eval(os.environ['COMPONENTS'])
    
    include = []
    for (k, v) in components.items():
        include.append(k)
    includeStr = ','.join(include)
    processes.append(['terrahub', 'init', '-i', includeStr])
    processes.append(['terrahub', os.environ['COMMAND'], '-i', includeStr, '-y'])
    execWithErrors(processes, os.environ['ROOT_PATH'])
    return terrahubOutput(include)

def terrahubOutput(include):
    response = {}

    for include_item in include:
        result = ''
        (error, result) = cli(['terrahub', 'output', '-o', 'json', '-i', include_item, '-y'], os.environ['ROOT_PATH'])
        if error == 0:
            response.update(extractOutputValues(result))

    output_file_path = os.path.join(os.environ['ROOT_PATH'], 'output.json')
    open(output_file_path, 'a').close()
    with open(output_file_path, 'wb') as json_file:
        json_file.write(json.dumps(response).encode("utf-8"))

    return 'Success'

def extractOutputValues(result):
    response = {}
    for (key, val) in json.loads(result).items():
        for (key_sub, val_sub) in val.items():
            try:
                response[key_sub]=getOutputValueByType(val_sub['value'])
            except:
                print('Warning: The key `' + key_sub + '` does NOT have any value defined.')
    
    return response

def getOutputValueByType(value):
    if isinstance(value, string_types):
        return value
    elif isinstance(value, list):
        return ','.join(map(str, value))
    else:
        response = []
        for (key, val) in value.items():
            response.append(key + '=' + getOutputValueByType(val))
        return '|'.join(response)

if __name__ == '__main__':
    RESP = main()
    print(RESP)
