#!/usr/bin/env bash
#
# Purpose: To download the images in the `landscape.md` file

if [[ ! -s landscape.md ]]; then
    echo "Call this script from the directory that has the 'landscape.md' file" >&2
    exit 1
fi

grep "http" landscape.md |                              # Grab lines that have links
perl -pe 's/^.*(http.*[^)]+)\)/$1/' |                   # Extract the links 
grep -E '.*.(jpg|jpeg|png)$' |                          # Only keep image links
xargs wget --no-clobber --directory-prefix=landscape    # Download the links with `wget`
