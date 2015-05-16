screenshot() {
    set_autoday_dir
    scrot -s '%Y_%m%d--%H%M_%S--'$(hostname)'--$wx$h.png' \
          -e 'mv $f \$AUTODAY_DIR 2>/dev/null'
}

alias sc="screenshot"
