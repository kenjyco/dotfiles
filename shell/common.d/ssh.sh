sshlazy() {
    if [[ ! $(ssh-add -l 2>/dev/null) =~ [0-9]+ ]]; then
        eval $(ssh-agent -s)
        for id_rsa in $(find $HOME/.ssh/ -type f -name "*rsa" | xargs -d \\n); do
            ssh-add $id_rsa
        done
    fi
}

local-ssh-hosts() {
    egrep "(192.168|10.0.0.)" -B 1 ~/.ssh/config | grep '^Host' | awk '{print $2}'
}
