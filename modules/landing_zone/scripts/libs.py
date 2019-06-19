import subprocess

def cli(args, root_path):
    p = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=root_path)
    (result, error) = p.communicate()
    if p.wait() != 0:
        return (1, error)
    else:
        return (0, result)

def execWithErrors(args_list):
    for args in args_list:
        (error, result) = cli(args, os.environ['root'])
        if error != 0:
            print("Error: failed to execute command:")
            raise Exception(result)

def execWithoutErrors(args_list):
    (error, result) = cli(args_list, os.environ['root'])
    if error != 0:
        print("Error: failed to execute command:")
        print(result)
