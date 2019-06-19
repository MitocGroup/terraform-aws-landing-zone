import os
import json
from libs import cli

def main():
    # components = eval(os.environ['components'])

    # include = []
    # for (k, v) in components.items():
    #     include.append(k)
    # include = ','.join(include)
    # (error, result) = cli(['terrahub', 'destroy', '-i', include, '-y', '-p', 'ignore'], os.environ['root'])
    # if error != 0:
    #     print("Error: failed to execute command:")
    #     raise Exception(result)

    return 'Success'

if __name__ == '__main__':
    RESP = main()
    print(RESP)
