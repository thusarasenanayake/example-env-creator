#!/usr/bin/env python

import subprocess

class Colorcodes(object):
    """
    https://gist.github.com/martin-ueding/4007035
    
    Provides ANSI terminal color codes which are gathered via the ``tput``
    utility. That way, they are portable. If there occurs any error with
    ``tput``, all codes are initialized as an empty string.
    The provides fields are listed below.
    Control:
    - bold
    - reset
    Colors:
    - blue
    - green
    - orange
    - red
    :license: MIT
    """
    def __init__(self):
        try:
            self.bold = subprocess.check_output("tput bold".split()).decode('latin1')
            self.reset = subprocess.check_output("tput sgr0".split()).decode('latin1')
            self.blue = subprocess.check_output("tput setaf 4".split()).decode('latin1')
            self.green = subprocess.check_output("tput setaf 2".split()).decode('latin1')
            self.orange = subprocess.check_output("tput setaf 3".split()).decode('latin1')
            self.red = subprocess.check_output("tput setaf 1".split()).decode('latin1')
        except subprocess.CalledProcessError as e:
            self.bold = ""
            self.reset = ""
            self.blue = ""
            self.green = ""
            self.orange = ""
            self.red = ""
            
import sys

def generate_env_example(input_file=".env", output_file=".env.example"):
    try:
        with open(input_file, 'r') as f:
            lines = f.readlines()
    except FileNotFoundError:
        print(pencil.red + f"\nerror: file '{input_file}' not found.\n")
        return

    keys = []
    for index, line in enumerate(lines):
        line = line.strip()
        tail = '' if len(lines) - 1 == index else '\n' 

        if line and not line.startswith('#'):
            key = line.split('=')[0].strip()
            keys.append(key + "=" + tail)
        else:
            keys.append(line + tail)

    with open(output_file, 'w') as f:
        for key in keys:
            f.write(key)

    print(pencil.green +  f"\nsuccess: generated '{output_file}' successfully.\n")


if __name__ == "__main__":

    pencil = Colorcodes()

    input_file = ".env" if len(sys.argv) < 2 else sys.argv[1]
    output_file = ".env.example"
    generate_env_example(input_file, output_file)
