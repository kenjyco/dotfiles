[[ $(uname) == 'Darwin' ]] && return

connected-displays() {
    xrandr -q | grep -e '\bconnected\b' | perl -pe 's/^([\S]+).* (\d+x\d+).*/$1:$2/'
}

fix-monitors() {
    position=${1:-above}
    allowed=(above below left-of right-of same-as)
    ok=
    for pos in "${allowed[@]}"; do
        [[ "$pos" == "$position" ]] && ok=yes && break
    done
    [[ -z "$ok" ]] && echo "Must pass in one of (${allowed[@]}) not \"$position\"" && return

    cmds=()
    names=()
    cmd=
    IFS=$'\n'; for line in $(xrandr -q | grep -A 1 -e '\bconnected\b'); do
        word=$(echo "$line" | awk '{print $1}')
        if [[ "$word" =~ ^[A-Z] || "$word" =~ ^[a-z] ]]; then
            cmd="xrandr --output $word --mode "
            names+=($word)
        elif [[ "$word" =~ ^[0-9] ]]; then
            cmd+="$word "
            if [[ -z "${cmds[@]}" ]]; then
                cmd+="--primary"
            else
                cmd+="--$position ${names[-2]}"
            fi
            cmds+=($cmd)
        fi
    done; unset IFS
    echo -e "\nCurrent:\n$(connected-displays)\n\nWould execute:"
    for cmd in "${cmds[@]}"; do
        echo " -> $cmd"
    done
    message="Continue? (y/n): "
    if [[ -n "$BASH_VERSION" ]]; then
        read -p "$message" yn
    elif [[ -n "$ZSH_VERSION" ]]; then
        vared -p "$message" -c yn
    fi
    [[ ! "$yn" =~ [yY].* ]] && return
    for cmd in "${cmds[@]}"; do
        eval "$cmd"
    done
}

fix-monitors-x200-below-1920() {
    xrandr --output VGA1 --mode 1920x1080 --primary
    xrandr --output LVDS1 --mode 1280x800 --below VGA1
}

fix-monitors-t530-below-1920() {
    xrandr --output VGA2 --mode 1920x1080 --primary
    xrandr --output LVDS2 --mode 1920x1080 --below VGA2
}

fix-monitors-t420-below-1920() {
    xrandr --output VGA1 --mode 1920x1080 --primary
    xrandr --output LVDS1 --mode 1366x768 --below VGA1
}

fix-monitors-t420-below-1280() {
    xrandr --output VGA1 --mode 1280x720 --primary
    xrandr --output LVDS1 --mode 1366x768 --below VGA1
}

fix-monitors-yoga-below-1920() {
    xrandr --output HDMI1 --mode 1920x1080 --primary
    xrandr --output eDP1 --mode 1366x768 --below HDMI1
}

fix-monitors-x200-portrait-right-1920() {
    xrandr --output VGA1 --mode 1920x1080 --primary
    xrandr --output LVDS1 --mode 1280x800 --rotate left --right-of VGA1
}

fix-monitors-tv-vga() {
    xrandr --output LVDS1 --off
    xrandr --output VGA1 --mode 1920x1080
    xrandr --output VGA1 --primary
}

fix-monitors-tv-hdmi() {
    xrandr --output LVDS1 --off
    xrandr --output HDMI1 --mode 1920x1080
    xrandr --output HDMI1 --primary
}

fix-monitors-edge-tv() {
    xrandr --output eDP1 --off
    xrandr --output HDMI1 --mode 1920x1080
    xrandr --output HDMI1 --primary
}

fix-monitors-vm-single() {
    xrandr --output VGA-1 --mode 1920x1080 --primary
}

fix-monitors-vm-dual() {
    xrandr --output VGA-1 --mode 1920x1080 --primary
    xrandr --output VGA-2 --mode 1920x1080 --left-of VGA-1
}

fix-monitors-vm-dual-3440() {
    xrandr --output VGA-1 --mode 1920x1080 --primary
    xrandr --output VGA-2 --mode 3440x1440 --above VGA-1
}
