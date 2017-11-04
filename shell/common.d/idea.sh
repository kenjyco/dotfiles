idea-list() {
    findit "$@" --stamp --pattern "*.idea" 2>/dev/null | sort
}

idea-rm-empty() {
    _dirname=$1
    [[ -z "$_dirname" ]] && _dirname="."
    find $_dirname -name "*.idea" -empty -delete -print
}
