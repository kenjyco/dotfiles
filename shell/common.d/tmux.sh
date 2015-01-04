# Shortcut to detach & re-attach to a session that will also create the session
# if it doesn't exist
Tmux () {
    session_name=$1
    if [[ -z "$session_name" ]]; then
        [[ $(pwd) != $HOME ]] && session_name=$(basename $(pwd)) || session_name=0
    fi
    tmux -2 attach-session -t $session_name -d 2>/dev/null || tmux -2 new-session -s $session_name
}
