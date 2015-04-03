cdd() { mkdir -p "$1" && cd "$1" && pwd && ls -gothrA; }

today() {
    session_name=$(date +%b-%d)
    session_dir="$HOME/autoday/$session_name"
    mkdir -p "$session_dir" 2>/dev/null && cd "$session_dir"
}
