[[ $(uname) == "Darwin" ]] && return

screencast() {
    fname=$1
    if [[ -z "$fname" ]]; then
        fname="screencast--$(date +'%Y_%m%d-%a-%H%M%S').ogv"
    else
        fname="$fname--$(date +'%Y_%m%d-%a-%H%M%S').ogv"
    fi

    echo -e "\nctrl-alt-p to pause\nctrl-alt-s to stop\n"
    recordmydesktop --on-the-fly-encoding --no-frame --full-shots --follow-mouse --fps 4 -o $fname
}
