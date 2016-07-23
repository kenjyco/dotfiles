asciicast() {
    fname=$1
    if [[ -z "$fname" ]]; then
        fname="$(date +'%Y_%m%d-%a-%H%M%S').json"
    else
        fname="$fname--$(date +'%Y_%m%d-%a-%H%M%S').json"
    fi

    tmux -2 new-session -s cast -d
    asciinema rec -c "tmux attach-session -t cast" -w 2 "$fname"
    echo -e "Saved recording to $fname"
}
