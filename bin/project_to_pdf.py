#!/usr/bin/env python

import os
import re
import subprocess
from datetime import datetime
try:
    from scandir import walk
except ImportError:
    from os import walk

"""
Requires the `enscript` program (to create PDFs from code).
"""

def project_to_pdfs(project_dir, file_rx=None):
    """
    - project_dir is the root path to a project directory
    - file_rx is a regular expression for what file names should match
    """
    project_dir = os.path.abspath(os.path.expanduser(project_dir))
    os.chdir(project_dir)

    # Get the name of the directory where the pdf files will be created
    project_name = os.path.basename(project_dir)
    yyyy_mmdd = datetime.now().strftime('%Y_%m%d')
    outdir = '/tmp/{}--{}--PDFs'.format(project_name, yyyy_mmdd)
    if not os.path.exists(outdir):
        os.makedirs(outdir, mode=0700)

    # Generate the `short_dir_name()` function
    sub_rx = re.compile(r'^{}'.format(project_dir))
    def short_dir_name(path):
        path = sub_rx.sub('', path)
        if path.startswith('/'):
            path = path[1:]
        return path
        
    # Default file_rx if None is provided
    file_rx = file_rx or re.compile(r'.*\.(py|sh|bash|zsh|md|txt|idea|)$') 

    # Template for the enscript command
    enscript_cmd = 'enscript --color -f Courier10 -E -Z -q -p - {} | ps2pdf - {}'

    for dirpath, dirnames, filenames in walk(project_dir):
        files = [ f for f in filenames if file_rx.match(f) ]
        if not files:
            continue

        relpathpy = short_dir_name(dirpath).replace('/', '.')
        relpathother = short_dir_name(dirpath).replace('/', '--')

        for f in files:
            if f.endswith('.py'):
                if relpathpy:
                    pdf_name = relpathpy + '.' + os.path.splitext(f)[0] + '.pdf'
                else:
                    pdf_name = os.path.splitext(f)[0] + '.pdf'
            else:
                if relpathother:
                    pdf_name = relpathother + '--' + f + '.pdf'
                else:
                    pdf_name = f + '.pdf'

            # Calculate the relative path to the python file and the full
            # path to the output pdf, for the `enscript` command
            infile = os.path.join(short_dir_name(dirpath), f)
            outfile = os.path.join(outdir, pdf_name)
            cmd = enscript_cmd.format(infile, outfile)

            # Actually create the PDF file
            try:
                print '    {} ->\n    {}'.format(infile, outfile)
                subprocess.check_call(cmd, shell=True)
            except subprocess.CalledProcessError:
                print '\n\nFAILED: {}'.format(cmd)

if __name__ == '__main__':
    import sys

    try:
        some_dir = sys.argv[1]
    except IndexError:
        some_dir = '.'

    project_to_pdfs(some_dir)
