lazy-update() {
    sshlazy && time (all-repos-update; update-home-config) || return
    if [[ -n "$BASH_VERSION" ]]; then
        source ~/.bashrc
    elif [[ -n "$ZSH_VERSION" ]]; then
        source ~/.zshrc
    fi
}
