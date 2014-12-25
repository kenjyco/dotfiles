_ignore_tree_string="-I '.git|.cache|chromium|.dbus|.pki|.wicd'"

t() {
    dirname="$1"
    [[ -z "$dirname" ]] && dirname="."
    [[ ! -d "$dirname" ]] && dirname="."
    [[ "$dirname" == "." ]] && dirname=$(pwd)
    eval "tree -Fa $_ignore_tree_string $dirname | less -FX"
}

alias ta="tree -Fa"
alias td="tree -Fd"
alias tad="tree -Fad"
alias tda="tree -Fda"
alias tgit="tree -Fa -I '.git' | less -FX"
alias thome="tree -Fa $_ignore_tree_string $HOME | less -FX"
