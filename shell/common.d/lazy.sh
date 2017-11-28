lazy-update() {
    sshlazy && time (all-repos-update; update-home-config "$@") || return
    if [[ -n "$BASH_VERSION" ]]; then
        source ~/.bashrc
    elif [[ -n "$ZSH_VERSION" ]]; then
        source ~/.zshrc
    fi
}

weekend-refresh() {
    oldpwd=$(pwd)
    cd
    _output_diff=$(beu-repos-diff)
    _output_swps=$(swps)
    if [[ -z "$_output_diff" && -z "$_output_swps" ]]; then
        lazy-update "reinstall"
    fi
    beu-repos-diff
    cd "$oldpwd"
}
