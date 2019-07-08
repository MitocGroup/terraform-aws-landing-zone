import os
import json
import sys
sys.path.insert(0, '../../scripts/')
from libs import cli, terrahubOutput
from six import string_types

def main():
    components = eval(os.environ['COMPONENTS'])
    
    include = []
    for (k, v) in components.items():
        include.append(k)
    return terrahubOutput(include, False)

if __name__ == '__main__':
    RESP = main()
    print(RESP)
