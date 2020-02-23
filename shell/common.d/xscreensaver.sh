[[ $(uname) == "Darwin" ]] && return

alias stopsaver="xscreensaver-command -exit"

startsaver() {
    [[ -z $(pgrep xscreensaver) ]] && /usr/bin/xscreensaver -no-splash &
    xscreensaver-command -activate &
    disown
}

setsaver() {
    IFS=$'\n'; select saver in $(find $(cat ~/.dotfiles_path)/x/xscreensaver -type f); do
        cp -av "$saver" ~/.xscreensaver
        break
    done; unset IFS
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
        xscreensaver-command -lock &
        disown
    fi
}
