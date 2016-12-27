redis-usage() {
    dump_path=$1
    [[ -z "$dump_path" ]] && dump_path="/var/lib/redis/dump.rdb"
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
    if [[ ! -f "$dump_path" ]]; then
        echo "Dump file $dump_path was not found. Call again and pass in path to the dump.rdb file" >&2
        return 1
    fi
    rdb -c memory "$dump_path" | sort -t, -k4 -h
}
