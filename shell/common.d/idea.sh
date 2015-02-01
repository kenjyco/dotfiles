idea-list() {
    dirname=$1
    [[ ! -z "$dirname" ]] && shift || dirname="$HOME"
    findit $dirname --stamp --pattern "*.idea" $@ 2>/dev/null | sort
}

idea-rm-empty() {
    dirname=$1
    [[ ! -z "$dirname" ]] && shift || dirname="$HOME"
    find $dirname -name "*.idea" -empty -delete
}
