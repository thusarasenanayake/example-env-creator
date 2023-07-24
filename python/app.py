import sys
from color_codes import Colorcodes

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
