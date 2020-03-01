[[ $(uname) == "Darwin" ]] && return

alias feh="feh -x --scale-down"
alias fehf="feh -F --zoom max"
alias fehfd="feh -Fd"

select-wallpaper() {
    echo "one" > $HOME/.selected_wallpaper_mode
    "$HOME/wallpapers/select.sh"
}

select-wallpaper-mode() {
    echo "Select wallpaper mode"
    choices=(one random none)
    select choice in "${choices[@]}"; do
        echo "$choice" > $HOME/.selected_wallpaper_mode
        break
    done
}
