alias update-submodules="git submodule foreach 'git checkout master && git pull origin master'"

alias glog="git log --pretty=format:'%C(yellow)%h %C(reset)%s %C(red)%ad %C(blue)%an'"
alias glog2="glog --date local --name-status"
alias glogp="git log -p --full-diff"

repo-list() {
    level=$1
    [[ ! "$level" =~ [0-9]+ ]] && level=3
    find ~ -maxdepth $level -type d -name ".git" | xargs -d \\n dirname 2>/dev/null | sort
}

repo-remotes() {
    for repo in $(repo-list | xargs -d \\n); do
        echo -e "\n$repo"
        grep url $repo/.git/config
    done
}

_repo-status() {
    oldpwd=$(pwd)
    for repo in $(repo-list | xargs -d \\n); do
        cd $repo
        output=$(git status -s)
        [[ ! -z "$output" ]] && echo -e "\n===============\n$(pwd)\n$output"
    done
    cd "$oldpwd"
}
alias repo-status="_repo-status | less -FX"
