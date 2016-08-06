cdd() { mkdir -p "$1" && cd "$1" && pwd; }

today() {
    set_autoday_dir
    cd $AUTODAY_DIR
}
