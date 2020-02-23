redis-usage() {
    dump_path=$1
    if [[ -z "$dump_path" ]]; then
        if [[ -d /var/lib/redis ]]; then
            dump_path="/var/lib/redis/dump.rdb"
        elif [[ -d /usr/local/var/db/redis ]]; then
            dump_path="/usr/local/var/db/redis/dump.rdb"
        fi
    fi
    seconds_since_save=$(($(date +"%s") - $(redis-cli lastsave)))
    if [[ $seconds_since_save -gt 1000 ]]; then
        redis-cli bgsave >/dev/null
        echo "Running bgsave command since it was $seconds_since_save seconds since last save" >&2
        while [[ $seconds_since_save -gt 1000 ]]; do
            sleep 1
            seconds_since_save=$(($(date +"%s") - $(redis-cli lastsave)))
        done
        echo "Finished bgsave command" >&2
    fi
    if [[ $(uname) == "Darwin" ]]; then
        rdb -c memory "$dump_path" | sort -t, -k4 -h
    else
        sudo rdb -c memory "$dump_path" | sort -t, -k4 -h
    fi
}
