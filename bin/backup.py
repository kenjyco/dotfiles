#!/usr/bin/env python3

"""
Wrapper to the `rsync` command

Usage:

  % backup.py [source [destination]]

Defaults:

  - source: current directory
  - destination: environment variable BACKUP_DIR

https://raw.githubusercontent.com/kenjyco/dotfiles/master/bin/backup.py
"""

import os
import subprocess


DEFAULT_EXCLUDES = [
    'env', 'venv', '__pycache__', '.npm', '*.swp', '.cache', 'cache',
    '.mozilla', 'chromium',
]
BACKUP_DIR = os.environ.get('BACKUP_DIR', '')


def backup(source='.', destination='', mirror=False, excludes=[],
           use_default_excludes=True, confirm=True):
    """Use `rsync` to backup

    - source: a directory with read permission
        - defaults to current directory
    - destination: optional directory location
        - must have write permission on its parent directory if the location
          does not exist yet
        - defaults to whatever is at environment variable BACKUP_DIR
    - mirror: if True, force destination to be a mirror copy of source
    - excludes: list of file/directory patterns to exclude
    - use_default_excludes: if True, add global "DEFAULT_EXCLUDES" to excludes
      list
    - confirm: if True, print args and ask user if they want to continue
    """
    source = os.path.abspath(os.path.expanduser(source))
    destination = destination or BACKUP_DIR
    if use_default_excludes:
        excludes += DEFAULT_EXCLUDES

    # Modify the destination if it is not a manually specified remote location
    if destination and not ':' in destination:
        if destination[0] in ('~', '/') or destination[:2] == '..':
            # Assume destination is a path on the local machine
            destination = os.path.abspath(os.path.expanduser(destination))
        elif destination != BACKUP_DIR:
            # Assume destination should be a sub-directory of BACKUP_DIR
            destination = os.path.join(BACKUP_DIR, destination)

    if not destination:
        raise Exception('No destination directory specified (and no BACKUP_DIR is set)')

    if not os.path.isdir(source):
        raise Exception('Source {} does not exist'.format(repr(source)))

    # The `rsync` command will have unintended behavior if trailing slashes are "wrong"
    if source.endswith('/'):
        source = source[:-1]
    if not destination.endswith('/'):
        destination += '/'

    if destination[:-1] == source:
        raise Exception('Source cannot be the destination!')

    if not ':' in destination and not os.path.exists(destination):
        print('Creating destination {}'.format(repr(destination)))
        os.makedirs(destination, mode=700)

    if mirror:
        rsync_cmd = 'rsync -hrltpEWvPc --delete-during --force'
    else:
        rsync_cmd = 'rsync -hrltpEWvPbc --suffix .dup'

    exclude_string = ' '.join([' --exclude {}'.format(ex) for ex in excludes])

    rsync_cmd += exclude_string + ' {} {}'.format(repr(source), repr(destination))
    print(rsync_cmd)
    choice = input('Continue? (Y/N): ')
    if not choice.lower().startswith('y'):
        return

    return subprocess.call(rsync_cmd, shell=True)


if __name__ == '__main__':
    import sys

    kwargs = {}
    try:
        kwargs['destination'] = sys.argv[2]
    except IndexError:
        pass
    try:
        kwargs['source'] = sys.argv[1]
    except IndexError:
        pass

    backup(**kwargs)
