# Specify in the terminal what fontsize you want going forward, useful before
# starting a `Tmux` session in full-screen
fontsize () {
    printf '\33]50;%s' "xft:DejaVu Sans Mono:size=$1"
    export FONT_SIZE=$1
}
