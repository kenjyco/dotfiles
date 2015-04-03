alias stopsaver="xscreensaver-command -exit"

startsaver() {
    [[ -z $(pgrep xscreensaver) ]] && /usr/bin/xscreensaver -no-splash &
    xscreensaver-command -activate &
    disown
}

lockscreen() {
    if [[ -z "$DISPLAY" ]]; then
        if [[ -n "$TMUX" ]]; then
            echo "Call 'lockscreen' again after tmux detaches..."
            sleep 2
            tmux detach-client
            return
        else
            vlock
        fi
    else
        [[ -z $(pgrep xscreensaver) ]] && /usr/bin/xscreensaver -no-splash &
        xscreensaver-command -lock
    fi
}
