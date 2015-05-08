tall-tmux() {
    urxvt -title 'tall-tmux' -geometry 83x50 -e zsh -c 'tmux' &
    [[ $? -eq 0 ]] && disown && exit
}

tall-tmux2() {
    urxvt -title 'tall-tmux' -geometry 128x50 -e zsh -c 'tmux' &
    [[ $? -eq 0 ]] && disown && exit
}

tall-wide() {
    urxvt -title 'tall-wide' -geometry 166x50 -e zsh &
    [[ $? -eq 0 ]] && disown && exit
}

tallp1360() {
    urxvt -title 'tall' -geometry 128x50 -e zsh &
    [[ $? -eq 0 ]] && disown && exit
}

tall() {
    urxvt -title 'tall' -geometry 83x50 -e zsh &
    [[ $? -eq 0 ]] && disown && exit
}

skinny() {
    urxvt -title 'skinny' -geometry 47x50 -e zsh &
    [[ $? -eq 0 ]] && disown && exit
}

long() {
    urxvt -title 'long' -geometry 213x11 -e zsh &
    [[ $? -eq 0 ]] && disown && exit
}

double() {
    urxvt -title 'long' -geometry 107x60 -e zsh &
    disown
    urxvt -title 'long' -geometry 106x60 -e zsh &
    disown
    exit
}
