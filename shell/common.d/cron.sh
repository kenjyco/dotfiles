active-crons() {
    crontab -l | grep -vE '(^#|^$)'
}
