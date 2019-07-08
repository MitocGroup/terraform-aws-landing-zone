import os
import sys
import json
sys.path.insert(0, '../../scripts/')
from libs import cli, execWithErrors, terrahubOutput
from six import string_types

def main():
    processes = []
    components = eval(os.environ['COMPONENTS'])
    
    include = []
    for (k, v) in components.items():
        include.append(k)
    includeStr = ','.join(include)
    processes.append(['terrahub', 'run', '-i', includeStr, '-a', '-y'])
    
    execWithErrors(processes, os.environ['ROOT_PATH'])
    return terrahubOutput(include, True)

if __name__ == '__main__':
    RESP = main()
    print(RESP)
