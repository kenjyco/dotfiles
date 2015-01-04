findit-swp() {
    dirname=$1
    [[ ! -z "$dirname" ]] && shift || dirname="."
    findit $dirname --pattern ".*sw[po]" $@
}

findit-py() {
    dirname=$1
    [[ ! -z "$dirname" ]] && shift || dirname="."
    findit $dirname --pattern "*.py" $@
}
