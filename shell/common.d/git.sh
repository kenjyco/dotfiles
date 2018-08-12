alias update-submodules="git submodule foreach --recursive git pull origin master"

alias glog="git log --find-renames --no-merges --pretty=format:'%C(yellow)%h %C(reset)%s %C(red)%ad %C(blue)%an%C(reset)'"
alias glog2="glog --date local --name-status"
alias glog3="git log --find-renames --stat --reverse -p"

alias gstatus="repo-status--changes-only"
alias gstatus-all="all-repos-status--changes-only"

gstatus-ignored() {
    git status -s --ignored | grep '^!'
}
