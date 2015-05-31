alias update-submodules="git submodule foreach --recursive git pull origin master"

alias glog="git log --pretty=format:'%C(yellow)%h %C(reset)%s %C(red)%ad %C(blue)%an'"
alias glog2="glog --date local --name-status"

gstatus() {
    _repo_path=$(repo-path)
    _repo_remote=$(repo-remote)
    _repo_branch=$(branchname)
    newcommits=$(unpushed-commits)

    echo -e "$_repo_path -- $_repo_remote -- $_repo_branch"
    pwd
    git status -s
    [[ -n "$newcommits" ]] && echo -e "\nNot pushed\n$newcommits"
}

_repo-status() {
    oldpwd=$(pwd)
    echo "Showing repos that have changes"
    for repo in $(all-repos-list | xargs -d \\n); do
        cd $repo
        filestatus=$(git status -s)
        newcommits=$(unpushed-commits)
        branch=$(branchname)
        if [[ -n "$filestatus" || -n "$newcommits" ]]; then
            echo -e "\n===============\n$(pwd) -- $branch\n$filestatus"
            [[ -n "$newcommits" ]] && echo -e "\nNot pushed\n$newcommits"
        fi

    done
    cd "$oldpwd"
}
alias repo-status="_repo-status | less -FX"

repos-update-all() {
    sshlazy

    oldpwd=$(pwd)
    for repo in $(all-repos-list | xargs -d \\n); do
        cd $repo
        echo -e "\n===============\n$(pwd)"
        filestatus=$(git status -s)
        # remote=$(grep "remote \"origin\"" -A 2 .git/config | grep url | perl -pe 's/^\s+url = (.*)$/$1/')
        remote=$(repo-remote)
        branch=$(branchname)
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
