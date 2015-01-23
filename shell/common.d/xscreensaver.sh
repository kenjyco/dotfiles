alias stopsaver="xscreensaver-command -exit"

lockscreen() {
    if [[ -z "$DISPLAY" ]]; then
        vlock
    else
        [[ -z $(pgrep xscreensaver) ]] && /usr/bin/xscreensaver -no-splash &
        xscreensaver-command -lock
    fi
}
