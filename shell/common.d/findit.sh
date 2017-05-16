findit-swp() {
    dirname=$1
    if [[ "$dirname" =~ '--.*' ]]; then
        dirname="."
    elif [[ -z "$dirname" ]]; then
        dirname="."
    else
        shift 2>/dev/null
    fi
    findit $dirname --pattern ".*sw[po]" $@
}
alias swps="findit-swp . --stamp 2>/dev/null | sort"

findit-py() {
    dirname=$1
    if [[ "$dirname" =~ '--.*' ]]; then
        dirname="."
    elif [[ -z "$dirname" ]]; then
        dirname="."
    else
        shift 2>/dev/null
    fi
    findit $dirname --pattern "*.py" $@
}

findit-autoday() {
    findit ~/autoday $@
}

findit-pics() {
    dirname=$1
    if [[ "$dirname" =~ '--.*' ]]; then
        dirname="."
    elif [[ -z "$dirname" ]]; then
        dirname="."
    else
        shift 2>/dev/null
    fi
    findit $dirname --complex "\( -iname '*.png' -o -iname '*.jpg' \
        -o -iname '*.jpeg' -o -iname '*.gif' \)" $@
}

findit-vids() {
    dirname=$1
    if [[ "$dirname" =~ '--.*' ]]; then
        dirname="."
    elif [[ -z "$dirname" ]]; then
        dirname="."
    else
        shift 2>/dev/null
    fi
    findit $dirname --complex "\( -iname '*.mp4' -o -iname '*.flv' \
        -o -iname '*.mkv' -o -iname '*.ogv' -o -iname '*.mov' \
        -o -iname '*.webm' -o -iname '*.avi' \)" $@
}

play-vids() {
    findit-vids $@ --pipe "vlc --fullscreen" &>/dev/null &
}

vids() {
    findit-vids --depth 1 --stamp $@ | sort
}

vids-all() {
    findit-vids --stamp $@ | sort
}

findit-audio() {
    dirname=$1
    if [[ "$dirname" =~ '--.*' ]]; then
        dirname="."
    elif [[ -z "$dirname" ]]; then
        dirname="."
    else
        shift 2>/dev/null
    fi
    findit $dirname --complex "\( -iname '*.mp3' -o -iname '*.flac' \
        -o -iname '*.ogg' -o -iname '*.wav' \)" $@
}

findit-docs() {
    dirname=$1
    if [[ "$dirname" =~ '--.*' ]]; then
        dirname="."
    elif [[ -z "$dirname" ]]; then
        dirname="."
    else
        shift 2>/dev/null
    fi
    findit $dirname --complex "\( -iname '*.pdf' -o -iname '*.doc' \
        -o -iname '*.odt' \)" $@
}

docs() {
    findit-docs --depth 1 --stamp $@ | sort
}

docs-all() {
    findit-docs --stamp $@ | sort
}
