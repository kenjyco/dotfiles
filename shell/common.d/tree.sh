_ignore_tree="-I '.git|*.py[ocd]'"
_ignore_tree_dotfiles="${_ignore_tree%?}|backup_dotfiles|extra|Vundle.vim'"
_ignore_tree_home="${_ignore_tree_dotfiles%?}|.cache|chromium|.dbus|.pki|.wicd|.grip|.autoenv*'"
_ignore_tree_home="${_ignore_tree_home%?}|.plugin_install_dir|.autoenv*'"

t() {
    dirname="$1"
    level="$2"
    [[ -z "$dirname" ]] && dirname="."
    [[ ! -d "$dirname" ]] && dirname="."
    [[ "$dirname" == "." ]] && dirname=$(pwd)

    if [[ "$level" =~ [0-9]+ ]]; then
        eval "tree -Fa -L $level $_ignore_tree $dirname | less -FX"
    else
        eval "tree -Fa $_ignore_tree $dirname | less -FX"
    fi
}

alias ta="tree -Fa"
alias td="tree -Fd"
alias tad="tree -Fad"
alias tda="tree -Fda"
alias tgit="tree -Fa $_ignore_tree | less -FX"
alias tdotfiles="tree -Fa $_ignore_tree_dotfiles $(cat $HOME/.dotfiles_path) | less -FX"
alias thome="tree -Fa $_ignore_tree_home $HOME | less -FX"
