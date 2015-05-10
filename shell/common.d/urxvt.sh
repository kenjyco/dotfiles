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

double1920() {
    urxvt -title 'long' -geometry 96x63 -fn "xft:DejaVu Sans Mono:size=10" -e zsh &
    disown
    urxvt -title 'long' -geometry 96x63 -fn "xft:DejaVu Sans Mono:size=10" -e zsh &
    disown
    exit
}

triple1920() {
    urxvt -title 'long' -geometry 107x82 -e zsh &
    disown
    urxvt -title 'long' -geometry 106x82 -e zsh &
    disown
    urxvt -title 'long' -geometry 107x82 -e zsh &
    disown
    exit
}

windowsize() {
    size=$1
    [[ ! "$size" =~ [0-9]+ ]] && size=11
    urxvt -title "size-$size" -geometry 90x25 -fn "xft:DejaVu Sans Mono:size=$size" -e zsh &
    [[ $? -eq 0 ]] && disown && exit
}
