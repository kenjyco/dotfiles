cdd() { mkdir -p "$1" && cd "$1" && pwd && ls -gothrA | tail -n 5; }

today() {
    set_autoday_dir
    cd $AUTODAY_DIR
}
