# Shortcut to detach & re-attach to a session that will also create the session
# if it doesn't exist
Tmux () {
    session_name=$1
    if [[ -z "$session_name" ]]; then
        tmux -2
    else
        tmux -2 attach-session -t $session_name -d 2>/dev/null || tmux -2 new-session -s $session_name
    fi
}
