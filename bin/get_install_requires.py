#!/usr/bin/env python3
#
# Generate a combined requirements file from install_requires in setup.py files

import re
import subprocess


rx_install_requires = re.compile(r'.*install_requires.*?=.*?\[([^\]]+)')
output_filename = 'requirements-combined.txt'


def get_required_packages(path='setup.py'):
    """Return a list of packages from 'install_requires' section of setup.py"""
    with open(path, 'r') as fp:
        text = fp.read()

    one_line = re.sub('\r?\n', ' ', text)
    match = rx_install_requires.match(one_line)
    if match:
        required_packages = [
            x.replace("'", "").replace('"', '').replace(' ', '')
            for x in match.group(1).split(',')
        ]
    else:
        required_packages = []

    return required_packages


if __name__ == '__main__':
    import sys

    try:
        fnames = sys.argv[1:]
    except IndexError:
        print('Usage: get_install_requires.py path/to/setup.py ../other/path/setup.py')
        sys.exit()
    else:
        if not fnames:
            print('Usage: get_install_requires.py path/to/setup.py ../other/path/setup.py')
            sys.exit()

    packages = set()
    for fname in fnames:
        if fname.endswith('setup.py'):
            required_packages = get_required_packages(fname)
            packages.update(required_packages)

    lines = ['# Make sure there are not duplicate package names below\n']
    lines.extend(sorted(list(packages)))
    with open(output_filename, 'w') as fp:
        fp.write('\n'.join(lines) + '\n')
    cmd = 'vim {}'.format(repr(output_filename))
    subprocess.call(cmd, shell=True)
    print('\nCombined requirements in:', output_filename)
