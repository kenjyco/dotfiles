idea-list() {
    findit "$@" --stamp --pattern "*.idea" 2>/dev/null | sort
}

idea-rm-empty() {
    dirname=$1
    [[ -z "$dirname" ]] && dirname="."
    find $dirname -name "*.idea" -empty -delete -print
}
