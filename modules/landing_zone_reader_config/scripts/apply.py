import os
import json
from libs import cli, execWithErrors, execWithoutErrors
from six import string_types

def main():
    components = eval(os.environ['COMPONENTS'])
    
    include = []
    for k in components.keys():
        include.append(k)
    return terrahubOutput(include)

def terrahubOutput(include):
    response = {}
    output_map = []

    execWithoutErrors(['terrahub', 'configure', '-c', 'component.template.data', '-D', '-y', '-i', 'terrahub_load_outputs'], os.environ['ROOT_PATH'])
    for include_item in include:
        result = ''
        (error, result) = cli(['terrahub', 'output', '-o', 'json', '-i', include_item, '-y'], os.environ['ROOT_PATH'])
        if error == 0:
            prepare_output = 'map(' + ','.join(extractOutputValues(result)) + ')'
            output_map = output_map + [prepare_output]

    (error, result) = cli(['terrahub', 'configure', '-i', 'terrahub_load_outputs', '-c', 'component.template.output.terrahub_reader.value=${merge(' + ','.join(output_map) + ')}'], os.environ['ROOT_PATH'])
    if error != 0:
        print('Error')
    (error, result) = cli(['terrahub', 'run', '-i', 'terrahub_load_outputs', '-a', '-y'], os.environ['ROOT_PATH'])
    if error != 0:
        print('Error')
    (error, result) = cli(['terrahub', 'refresh', '-i', 'terrahub_load_outputs'], os.environ['ROOT_PATH'])
    if error != 0:
        print('Error')

    return 'Success'

def extractOutputValues(result):
    response = {}
    processes = []
    thub_cfg = ['terrahub', 'configure', '-i', 'terrahub_load_outputs', '-c']

    output_map = []
    for (key, val) in json.loads(result).items():
        processes.append(thub_cfg + ['component.template.data.terraform_remote_state.'+ key + '.backend=local'])
        processes.append(thub_cfg + ['component.template.data.terraform_remote_state.'+ key + '.config.path=${tfvar.terrahub["tfstate_path"]}/' + key + '/terraform.tfstate'])
        for key_sub in val.keys():
            output_map = output_map + ['"' + key_sub + '"', 'data.terraform_remote_state.' + key + '.' + key_sub]
    
    execWithErrors(processes, os.environ['ROOT_PATH'])

    return output_map

if __name__ == '__main__':
    RESP = main()
    print(RESP)
