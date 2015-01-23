idea-list() {
    dirname=$1
    [[ ! -z "$dirname" ]] && shift || dirname="$HOME"
    findit $dirname --stamp --pattern "*.idea" $@ 2>/dev/null | sort
}
