if [[ -s "/Applications/VLC.app/Contents/MacOS/VLC" ]]; then
    alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
fi

vlcf() {
    vlc --fullscreen $@ &>/dev/null &
}
