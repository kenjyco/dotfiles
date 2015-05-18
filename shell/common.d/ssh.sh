sshlazy() {
    if [[ $(ssh-add -l) =~ "The agent has no identities" ]]; then
        eval $(ssh-agent -s)
        ssh-add
    fi
}
