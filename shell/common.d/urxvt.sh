[[ $(uname) == 'Darwin' ]] && return

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

new-asciicast-win() {
    urxvt -title 'asciinema-optimized' -geometry 160x40 -e zsh &
    [[ $? -eq 0 ]] && disown && exit
}

new-looper-win() {
    urxvt -title 'looper' -geometry 213x5 -e zsh -c 'source ~/.zshrc && looper' &
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
    urxvt -title 'half-a' -geometry 107x60 -e zsh &
    disown
    urxvt -title 'half-b' -geometry 106x60 -e zsh &
    disown
    exit
}

double1920() {
    if [[ -n "$1" ]]; then
        urxvt -title 'half-a' -geometry 96x63 -fn "xft:Inconsolata:size=10" -e zsh &
        disown
        urxvt -title 'half-b' -geometry 96x63 -fn "xft:Inconsolata:size=10" -e zsh &
        disown
    else
        urxvt -title 'half-a' -geometry 160x82 -e zsh &
        disown
        urxvt -title 'half-b' -geometry 160x82 -e zsh &
        disown
    fi
    exit
}

triple1920() {
    urxvt -title 'third-a' -geometry 107x82 -e zsh &
    disown
    urxvt -title 'third-b' -geometry 106x82 -e zsh &
    disown
    urxvt -title 'third-c' -geometry 107x82 -e zsh &
    disown
    exit
}

newwin(){
    title=$1
    geom=$2
    cmd='urxvt'
    if [[ -z "$title" ]]; then
        cmd="${cmd} -title \"$(basename $(pwd)) .::. $(date +'%b-%d at %I:%M%p')\""
    else
        cmd="${cmd} -title \"$title .::. $(date +'%b-%d at %I:%M%p')\""
    fi
    if [[ -n "$geom" ]]; then
        cmd="${cmd} -geometry $geom"
    fi
    echo "$cmd"
    exec eval "$cmd" &
    [[ $? -eq 0 ]] && disown && exit
}

# same dimensions as 'tall-wide'
lazy() {
    cd "$1" && activate &>/dev/null && sshlazy || return 1 ;
    if [[ -z "$1" ]]; then
        urxvt -title "$(basename $(pwd)) [lazy]" -geometry 166x50 -e zsh &
    else
        urxvt -title "$1 [lazy]" -geometry 166x50 -e zsh &
    fi
    [[ $? -eq 0 ]] && disown && exit
}

lazy1920() {
    cd "$1" && activate &>/dev/null && sshlazy || return 1 ;
    if [[ -z "$1" ]]; then
        urxvt -title "$(basename $(pwd)) [lazy]" -geometry 106x82 -e zsh &
    else
        urxvt -title "$1 [lazy]" -geometry 106x82 -e zsh &
    fi
    [[ $? -eq 0 ]] && disown && exit
}

lazy2560() {
    cd "$1" && activate &>/dev/null && sshlazy
    if [[ -z "$1" ]]; then
        urxvt -title "$(basename $(pwd)) [lazy]" -geometry 106x110 -e zsh &
    else
        urxvt -title "$1 [lazy]" -geometry 106x110 -e zsh &
    fi
    [[ $? -eq 0 ]] && disown && exit
}

work(){
    urxvt -title 'work-tmux' -geometry 83x60 -e zsh -c 'tmux' &
    disown
    urxvt -title 'half-a' -geometry 130x30 -e zsh &
    disown
    urxvt -title 'half-b' -geometry 130x30 -e zsh &
    disown
    exit
}

work1920() {
    urxvt -title 'work-tmux' -geometry 106x82 -e zsh -c 'tmux' &
    disown
    urxvt -title 'quad-a' -geometry 107x41 -e zsh &
    disown
    urxvt -title 'quad-b' -geometry 107x41 -e zsh &
    disown
    urxvt -title 'quad-c' -geometry 107x41 -e zsh &
    disown
    urxvt -title 'quad-d' -geometry 107x41 -e zsh &
    disown
    exit
}

windowsize() {
    size=$1
    [[ ! "$size" =~ [0-9]+ ]] && size=11
    urxvt -title "size-$size" -geometry 90x25 -fn "xft:Inconsolata:size=$size" -e zsh &
    [[ $? -eq 0 ]] && disown && exit
}
