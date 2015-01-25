screenshot() {
    [[ ! -d "$HOME/screenshots" ]] && mkdir "$HOME/screenshots"
    scrot -s '%Y_%m%d--%H%M_%S--'`hostname`'--$wx$h.png' \
          -e 'mv $f ~/screenshots 2>/dev/null'
}

