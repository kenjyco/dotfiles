_ignore_tree="-I '.git|node_modules|*.py[ocd]|include|lib|local|share|build|dryscrape|webkit-server|__pycache__|.cache|.eggs'"
_ignore_tree_dotfiles="${_ignore_tree%?}|backup_dotfiles|extra|Vundle.vim'"
_ignore_tree_home="${_ignore_tree_dotfiles%?}|chromium|.dbus|.pki|.wicd|.grip|.autoenv*'"
_ignore_tree_home="${_ignore_tree_home%?}|.plugin_install_dir|.dropbox*|Dropbox'"
_ignore_tree_home="${_ignore_tree_home%?}|.mozilla|.local|.gimp|.thumbnails'"

t() {
    dirname="$1"
    level="$2"
    [[ -z "$dirname" ]] && dirname="."
    [[ ! -d "$dirname" ]] && dirname="."
    oldpwd=$(pwd)
    cd "$dirname"

    local ignore=$_ignore_tree
    [[ $(pwd) == $HOME ]] && ignore=$_ignore_tree_home
    [[ $(pwd) =~ "$(cat $HOME/.dotfiles_path)" ]] && ignore=$_ignore_tree_dotfiles

    if [[ "$level" =~ [0-9]+ ]]; then
        echo -e "tree -Fa -L $level $ignore $dirname | less -FX\n$(pwd)" >&2
        eval "tree -Fa -L $level $ignore . | less -FX"
    else
        echo -e "tree -Fa $ignore $dirname | less -FX\n$(pwd)" >&2
        eval "tree -Fa $ignore . | less -FX"
    fi

    cd "$oldpwd"
}

alias ta="tree -Fa"
alias td="tree -Fd"
alias tad="tree -Fad"
alias tda="tree -Fda"
