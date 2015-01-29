tall() {
    urxvt -title 'tmux-time' -geometry 83x50 -e zsh -c 'tmux' &
    [[ $? -eq 0 ]] && disown && exit
}
