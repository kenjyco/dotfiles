now() {
    [[ $(uname) == 'Darwin' ]] && date +'%a %I:%M' || banner $(date +'%a %I:%M')
}

utcnow() {
    python -c 'from datetime import datetime; print(datetime.utcnow())'
}
