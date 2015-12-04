shgrep() {
    pattern=$1
    a=$2
    b=$3
    [[ -z "$pattern" ]] && exit 1
    [[ -z "$a" ]] && a=0
    [[ -z "$b" ]] && b=0

    grep --color -Hn -P $pattern -A $a -B $b \
    ~/.shell/bash/bash* ~/.shell/zsh/zshrc ~/.shell/common ~/.shell/common.d/* \
    ~/bin/**/* ~/.config/ranger/rc.conf ~/.config/awesome/rc.lua 2>/dev/null
}

pygrep() {
    pattern=$1
    a=$2
    b=$3
    [[ -z "$pattern" ]] && exit 1
    [[ -z "$a" ]] && a=0
    [[ -z "$b" ]] && b=0

    # FIXME: Shouldn't hardcode these links in
    # FIXME: This is not a bash-safe pattern
    if [[ -n $ZSH_VERSION ]]; then
        grep --color -Hn -P $pattern -A $a -B $b ~/kenjyco/(^env/)#*.py ~/extract_utils/(^env/)#*.py ~/redis_helper/(^env/)#*.py ~/chloop/(^env/)#*.py $(cat ~/.dotfiles_path)/bin/**/*.py 2>/dev/null
    fi
}
