import subprocess

def cli(args, root_path):
    p = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=root_path)
    (result, error) = p.communicate()
    if p.wait() != 0:
        return (1, error)
    else:
        return (0, result)

def execWithErrors(args_list, root_path):
    for args in args_list:
        (error, result) = cli(args, root_path)
        if error != 0:
            print("Error: failed to execute command:")
            raise Exception(result)

def execWithoutErrors(args_list, root_path):
    (error, result) = cli(args_list, root_path)
    if error != 0:
        print("Error: failed to execute command:")
        print(result)

def terrahubOutput(include, compressing):
    response = {}

    for include_item in include:
        result = ''
        (error, result) = cli(['terrahub', 'output', '-o', 'json', '-i', include_item, '-y'], os.environ['ROOT_PATH'])
        if error == 0:
            response.update(extractOutputValues(result, compressing))

    output_file_path = os.path.join(os.environ['ROOT_PATH'], 'output.json')
    open(output_file_path, 'a').close()
    with open(output_file_path, 'wb') as json_file:
        json_file.write(json.dumps(response).encode("utf-8"))

    return 'Success'

def extractOutputValues(result, compressing):
    response = {}
    for (key, val) in json.loads(result).items():
        for (key_sub, val_sub) in val.items():
            try:
                if compressing:
                        response[key_sub]=getOutputValueByType(val_sub['value'])
                else:
                        response[key_sub]=val_sub['value']
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
