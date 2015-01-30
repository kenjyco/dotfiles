findit-swp() {
    dirname=$1
    [[ ! -z "$dirname" ]] && shift || dirname="."
    findit $dirname --pattern ".*sw[po]" $@
}
alias swps="findit-swp . --stamp 2>/dev/null | sort -h"

findit-py() {
    dirname=$1
    [[ ! -z "$dirname" ]] && shift || dirname="."
    findit $dirname --pattern "*.py" $@
}

findit-pics() {
    dirname=$1
    [[ ! -z "$dirname" ]] && shift || dirname="."
    findit $dirname --complex "\( -iname '*.png' -o -iname '*.jpg' \
        -o -iname '*.jpeg' -o -iname '*.gif' \)" $@
}

findit-vids() {
    dirname=$1
    [[ ! -z "$dirname" ]] && shift || dirname="."
    findit $dirname --complex "\( -iname '*.mp4' -o -iname '*.flv' \
        -o -iname '*.mkv' -o -iname '*.ogv' -o -iname '*.avi' \)" $@
}

findit-audio() {
    dirname=$1
    [[ ! -z "$dirname" ]] && shift || dirname="."
    findit $dirname --complex "\( -iname '*.mp3' -o -iname '*.flac' \
        -o -iname '*.ogg' -o -iname '*.wav' \)" $@
}

findit-docs() {
    dirname=$1
    [[ ! -z "$dirname" ]] && shift || dirname="."
    findit $dirname --complex "\( -iname '*.pdf' -o -iname '*.doc' \
        -o -iname '*.odt' \)" $@
}
