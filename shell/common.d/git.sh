alias update-submodules="git submodule foreach --recursive git pull origin master"
alias branchname="git rev-parse --abbrev-ref HEAD 2>/dev/null"

alias glog="git log --pretty=format:'%C(yellow)%h %C(reset)%s %C(red)%ad %C(blue)%an'"
alias glog2="glog --date local --name-status"
alias glogp="git log -p --full-diff"

gstatus() {
    oldpwd=$(pwd)

    # Determine repository path
    dirname=$(pwd)
    while [[ ! -d "$dirname/.git" ]]; do
        cd ..
        dirname=$(pwd)

        if [[ $(pwd) == '/' ]]; then
            cd $oldpwd
            return 1
        fi
    done
    _repo_path=$(pwd)

    # Determine other relevant info
    _repo_remote=$(grep "remote \"origin\"" -A 2 .git/config | grep url | perl -pe 's/^\s+url = (.*)$/$1/')
    _repo_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

    cd $oldpwd
    echo -e "$_repo_path -- $_repo_remote -- $_repo_branch"
    pwd
    git status -s
}

repo-list() {
    level=$1
    [[ ! "$level" =~ [0-9]+ ]] && level=3
    find ~ -maxdepth $level -type d -name ".git" | xargs -d \\n dirname 2>/dev/null | sort
}

repo-remotes() {
    for repo in $(repo-list | xargs -d \\n); do
        _repo_remote=$(grep "remote \"origin\"" -A 2 $repo/.git/config | grep url | perl -pe 's/^\s+url = (.*)$/$1/')
        echo -e "$repo -- $_repo_remote"
    done
}

_repo-status() {
    oldpwd=$(pwd)
    echo "Showing repos that have changes"
    for repo in $(repo-list | xargs -d \\n); do
        cd $repo
        filestatus=$(git status -s)
        newcommits=$(git log  @{u}.. 2>/dev/null)
        branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        if [[ -n "$filestatus" || -n "$newcommits" ]]; then
            echo -e "\n===============\n$(pwd) -- $branch\n$filestatus"
            [[ -n "$newcommits" ]] && echo $newcommits
        fi

    done
    cd "$oldpwd"
}
alias repo-status="_repo-status | less -FX"

repos-update-all() {
    sshlazy

    oldpwd=$(pwd)
    for repo in $(repo-list | xargs -d \\n); do
        cd $repo
        echo -e "\n===============\n$(pwd)"
        filestatus=$(git status -s)
        remote=$(grep "remote \"origin\"" -A 2 .git/config | grep url | perl -pe 's/^\s+url = (.*)$/$1/')
        branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        if [[ -z "$remote" ]]; then
            echo " - Local-only repo, not updating"
        elif [[ -z "$filestatus" ]]; then
            echo " - Repository is clean.. gonna do 'pull'"
            git pull
        elif [[ "$branch" =~ (master|production) ]]; then
            stashstatus=$(git stash)
            if [[ $stashstatus == "No local changes to save" ]]; then
                echo " - Repository is clean (w/ untracked files).. gonna do 'pull'"
                git pull
            else
                echo " - Dirty repo on master or production.. gonna do 'stash pull pop'"
                echo "$stashstatus"
                git pull
                git stash pop
            fi
        else
            echo " - Dirty random branch, not updating"
        fi
    done
    cd "$oldpwd"
}
