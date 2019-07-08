import os
import json
import sys
sys.path.insert(0, '../../scripts/')
from libs import cli
from six import string_types

def main():
    components = eval(os.environ['COMPONENTS'])
    
    include = []
    for (k, v) in components.items():
        include.append(k)
    return terrahubOutput(include)

def terrahubOutput(include_components):
    response_output = {}

    for include_component in include_components:
        result_output = ''
        (error, result_output) = cli(['terrahub', 'output', '-o', 'json', '-i', include_component, '-y'], os.environ['ROOT_PATH'])
        if error == 0:
            response_output.update(extractOutputValues(result_output))

    output_file_path = os.path.join(os.environ['ROOT_PATH'], 'output.json')
    open(output_file_path, 'a').close()
    with open(output_file_path, 'wb') as json_file:
        json_file.write(json.dumps(response_output).encode("utf-8"))

    return 'Success'

def extractOutputValues(result):
    response = {}
    for (key, val) in json.loads(result).items():
        for (key_sub, val_sub) in val.items():
            try:
                response[key_sub]=val_sub['value']
            except:
                print('Warning: The key `' + key_sub + '` does NOT have any value defined.')
    
    return response

if __name__ == '__main__':
    RESP = main()
    print(RESP)
