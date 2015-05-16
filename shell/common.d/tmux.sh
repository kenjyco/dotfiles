# Detach and re-attach to a specified session.
#   - if the session doesn't exist, create it
#   - if no session is specified, use a session named for the current date
#     (i.e. Feb-01) and start the session from "$HOME/autoday/$session_name/"
Tmux() {
    session_name=$1
    if [[ -z "$session_name" ]]; then
        set_autoday_dir
        session_name=$(basename $AUTODAY_DIR)
        cd $AUTODAY_DIR
    fi

    tmux -2 attach-session -t $session_name -d 2>/dev/null || tmux -2 new-session -s $session_name
}
