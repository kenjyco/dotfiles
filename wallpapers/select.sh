#!/usr/bin/env bash

# Get the directory where this script lives
DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$DIR"
IFS=$'\n'
select image in $(grep -E "http.*(jpg|jpeg|png)" landscape.md); do
    fname=$(echo "$image" | perl -pe 's/^.*\/(.*)\)/$1/')
    fullpath="$DIR/landscape/$fname"
    echo "$fullpath" > $HOME/.selected_wallpaper_file
    [[ ! -f "$fullpath" ]] && ./download.sh
    feh --bg-fill $fullpath 2>/dev/null
    break
done
unset IFS
