alias stopsaver="xscreensaver-command -exit"

startsaver() {
    [[ -z $(pgrep xscreensaver) ]] && /usr/bin/xscreensaver -no-splash &
    xscreensaver-command -activate
}

lockscreen() {
    if [[ -z "$DISPLAY" ]]; then
        vlock
    else
        [[ -z $(pgrep xscreensaver) ]] && /usr/bin/xscreensaver -no-splash &
        xscreensaver-command -lock
    fi
}
