youtube() {
    if [[ "$1" =~ https?\: ]]; then
        link=$1
    fi

    if [[ -n "$link" && $# -eq 1 ]]; then
        echo "youtube-dl -v '$link' --write-description" >&2
        youtube-dl -v "$link" --write-description
        if [[ $? -eq 0 ]]; then
            echo $link >> yt-success.txt
        else
            echo $link >> yt-fail.txt
        fi
    else
        echo "youtube-dl -v $@ --write-description" >&2
        youtube-dl -v $@ --write-description
        if [[ $? -eq 0 ]]; then
            echo $@ >> yt-success-cmd.txt
        else
            echo $@ >> yt-fail-cmd.txt
        fi
    fi
}

youtube-audio() {
    if [[ "$1" =~ https?\: ]]; then
        link=$1
    fi

    if [[ -n "$link" && $# -eq 1 ]]; then
        echo "youtube-dl -vkx --audio-format mp3 '$link' --write-description" >&2
        youtube-dl -vkx --audio-format mp3 "$link" --write-description
        if [[ $? -eq 0 ]]; then
            echo $link >> yt-success-audio.txt
        else
            echo $link >> yt-fail-audio.txt
        fi
    else
        echo "youtube-dl -vkx --audio-format mp3 $@ --write-description" >&2
        youtube-dl -vkx --audio-format mp3 $@ --write-description
        if [[ $? -eq 0 ]]; then
            echo $@ >> yt-success-audio-cmd.txt
        else
            echo $@ >> yt-fail-audio-cmd.txt
        fi
    fi
}
