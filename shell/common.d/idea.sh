idea-list() {
    dirname=$1
    if [[ "$dirname" =~ '--.*' ]]; then
        dirname="$HOME"
    elif [[ -z "$dirname" ]]; then
        dirname="$HOME"
    else
        shift 2>/dev/null
    fi
    findit $dirname --stamp --pattern "*.idea" $@ 2>/dev/null | sort
}

idea-rm-empty() {
    dirname=$1
    [[ -n "$dirname" ]] && shift || dirname="$HOME"
    find $dirname -name "*.idea" -empty -delete
}
