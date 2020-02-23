[[ $(uname) == "Darwin" ]] && return

screenshot() {
    scrot -s '%Y_%m%d--%H%M_%S--'$(hostname)'--$wx$h.png'
}

screenshot-today() {
    [[ -z "$AUTODAY_DIR" ]] && set_autoday_dir
    scrot -s '%Y_%m%d--%H%M_%S--'$(hostname)'--$wx$h.png' \
          -e 'mv $f \$AUTODAY_DIR 2>/dev/null'
}

alias sc="screenshot-today"

scloop() {
    message="<ENTER> take screenshot (select area with mouse), <CTRL>+<C> to stop loop "
    while true; do
        if [[ -n "$BASH_VERSION" ]]; then
            read -p "$message" yn
        elif [[ -n "$ZSH_VERSION" ]]; then
            vared -p "$message" -c yn
        fi
        scrot -s '%Y_%m%d--%H%M_%S--'$(hostname)'--$wx$h.png'
    done
}

scloop-today() {
    message="<ENTER> take screenshot (select area with mouse), <CTRL>+<C> to stop loop "
    while true; do
        if [[ -n "$BASH_VERSION" ]]; then
            read -p "$message" yn
        elif [[ -n "$ZSH_VERSION" ]]; then
            vared -p "$message" -c yn
        fi
        screenshot
    done
}
