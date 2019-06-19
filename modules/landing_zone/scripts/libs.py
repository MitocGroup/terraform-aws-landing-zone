import subprocess

def cli(args, root_path):
    p = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=root_path)
    (result, error) = p.communicate()
    if p.wait() != 0:
        return (1, error)
    else:
        return (0, result)
