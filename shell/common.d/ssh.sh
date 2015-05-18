sshlazy() {
    if [[ ! $(ssh-add -l 2>/dev/null) =~ [0-9]+ ]]; then
        eval $(ssh-agent -s)
        ssh-add
    fi
}
