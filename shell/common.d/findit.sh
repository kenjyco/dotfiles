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
    findit $dirname --complex "-not \( -path '*/venv/*' -o -path '*/env/*' \
        -o -path '*/build/*' -prune \) -iname '*.py'" $@
}

pys() {
    findit-py --depth 1 --stamp $@ | sort
}

pys-all() {
    findit-py --stamp $@ | sort
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
    findit $dirname --complex "-not \( -path '*/.cache/*' -o -path '*/.config/*' \
        -o -path '*/.thumbnails/*' -o -path '*/.cinnamon/*' \
        -o -path '*/venv/*' -o -path '*/env/*' -prune \) \
        \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \
        -o -iname '*.gif' \)" $@
}

pics() {
    findit-pics --depth 1 --stamp $@ | sort
}

pics-all() {
    findit-pics --stamp $@ | sort
}

pics-view() {
    findit-pics --depth 1 $@ --pipesort "feh -Fd" &
}

pics-all-view() {
    findit-pics $@ --pipesort "feh -Fd" &
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

vids() {
    findit-vids --depth 1 --stamp $@ | sort
}

vids-all() {
    findit-vids --stamp $@ | sort
}

vids-play() {
    findit-vids --depth 1 $@ --pipesort "vlc --fullscreen" &>/dev/null &
}

vids-all-play() {
    findit-vids $@ --pipesort "vlc --fullscreen" &>/dev/null &
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
    findit $dirname --complex "-not \( -path '*/venv/*' -o -path '*/env/*' \
        -prune \) \( -iname '*.mp3' -o -iname '*.flac' \
        -o -iname '*.ogg' -o -iname '*.wav' \)" $@
}

audio() {
    findit-audio --depth 1 --stamp $@ | sort
}

audio-all() {
    findit-audio --stamp $@ | sort
}

audio-play() {
    mocp -S &>/dev/null
    mocp -c && findit-audio --depth 1 $@ --pipesort "mocp -a" && mocp -p
}

audio-all-play() {
    mocp -S &>/dev/null
    mocp -c && findit-audio $@ --pipesort "mocp -a" && mocp -p
}

findit-logs() {
    dirname=$1
    if [[ "$dirname" =~ '--.*' ]]; then
        dirname="."
    elif [[ -z "$dirname" ]]; then
        dirname="."
    else
        shift 2>/dev/null
    fi
    findit $dirname --complex "-iname '*.log' -type f ! -size 0" $@
}

findit-logs-empty() {
    dirname=$1
    if [[ "$dirname" =~ '--.*' ]]; then
        dirname="."
    elif [[ -z "$dirname" ]]; then
        dirname="."
    else
        shift 2>/dev/null
    fi
    findit $dirname --complex "-iname '*.log' -type f -empty" $@
}

findit-logs-empty-delete() {
    dirname=$1
    if [[ "$dirname" =~ '--.*' ]]; then
        dirname="."
    elif [[ -z "$dirname" ]]; then
        dirname="."
    else
        shift 2>/dev/null
    fi
    findit $dirname --complex "-iname '*.log' -type f -empty -delete" $@
}

logs() {
    findit-logs $@ --depth 1 --stamp | sort
}

logs-wcl() {
    findit-logs $@ --depth 1 --pipesort 'wc -l'
}

logs-info() {
    findit-logs $@ --depth 1 --pipesort 'grep -Hn --color INFO'
}

logs-error() {
    findit-logs $@ --depth 1 --pipesort 'grep -Hn --color ERROR'
}

logs-debug() {
    findit-logs $@ --depth 1 --pipesort 'grep -Hn --color DEBUG'
}

logs-all() {
    findit-logs $@ --stamp | sort
}

logs-all-wcl() {
    findit-logs $@ --pipesort 'wc -l'
}

logs-all-info() {
    findit-logs $@ --pipesort 'grep -Hn --color INFO'
}

logs-all-error() {
    findit-logs $@ --pipesort 'grep -Hn --color ERROR'
}

logs-all-debug() {
    findit-logs $@ --pipesort 'grep -Hn --color DEBUG'
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
    findit $dirname --complex "-not \( -path '*/venv/*' -o -path '*/env/*' \
        -prune \) \( -iname '*.pdf' -o -iname '*.doc' \
        -o -iname '*.odt' -o -iname '*.md' \)" $@
}

docs() {
    findit-docs --depth 1 --stamp $@ | sort
}

docs-all() {
    findit-docs --stamp $@ | sort
}

annotated() {
    findit --pattern 'annotated*pdf' --stamp $@ | sort
}
