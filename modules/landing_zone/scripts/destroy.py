import os
import json
import sys
sys.path.insert(0, '../../scripts/')
from libs import cli

def main():
    root_path = os.environ['ROOT_PATH']
    components = eval(os.environ['COMPONENTS'])

    include = []
    for (k, v) in components.items():
        include.append(k)
    include = ','.join(include)
    (error, result) = cli(['terrahub', 'destroy', '-i', include, '-y', '-p', 'ignore'], root_path)
    if error != 0:
        print("Error: failed to execute command:")
        raise Exception(result)

    return 'Success'

if __name__ == '__main__':
    RESP = main()
    print(RESP)
