sshlazy() {
    if [[ ! $(ssh-add -l 2>/dev/null) =~ [0-9]+ ]]; then
        eval $(ssh-agent -s)
        for id_rsa in $(find $HOME/.ssh -type f -name "*rsa" -print0 | xargs -0); do
            ssh-add $id_rsa
        done
    fi
}

local-ssh-hosts() {
    egrep "(192.168|10.0.0.)" -B 1 ~/.ssh/config | grep '^Host' | awk '{print $2}'
}

other-hosts-status() {
    for server in $(local-ssh-hosts | grep -v $(hostname) | tr '\n' '\0' | xargs -0); do
        echo -e "\n\n\n\n"
        banner $server
        ssh $server -t 'source ~/.zshrc && mystats ip; echo -e "\n\n" && all-repos-status'
    done
}
