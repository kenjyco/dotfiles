asciicast() {
    title=$1
    now_string="$(date +'%Y_%m%d-%a-%H%M%S')"
    if [[ -z "$title" ]]; then
        title="misc--${now_string}"
    else
        title="${title}--${now_string}"
    fi
    fname="$title.json"

    tmux -2 new-session -s cast -d
    asciinema rec -c "tmux attach-session -t cast" -w 2 -t "$title" "$fname"
    echo -e "Saved recording to $fname"
}
