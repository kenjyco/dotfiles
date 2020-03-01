[[ $(uname) == "Darwin" ]] && return

alias feh="feh -x --scale-down"
alias fehf="feh -F --zoom max"
alias fehfd="feh -Fd"

select-wallpaper() {
    "$HOME/wallpapers/select.sh"
}

select-wallpaper-mode() {
    echo "Select wallpaper mode"
    choices=(none one random)
    select choice in "${choices[@]}"; do
        echo "$choice" > $HOME/.selected_wallpaper_mode
        break
    done
}
