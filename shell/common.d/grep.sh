env-check() {
    printenv | grep -i "$@"
}

grepit() {
    [[ -z "$@" ]] && return 1
    grep -HnI --color -R --exclude=\*.{pyc,swp,min.js,svg,png,jpg,jpeg,ttf,pdf,doc,xlsx,otf,mp3} --exclude-dir=venv --exclude-dir=env --exclude-dir=node_modules --exclude-dir=.git --exclude-dir=dist --exclude-dir=build --exclude-dir=.eggs --exclude-dir=.cache --exclude-dir=\*.egg-info "$@" \.
}

grepit-cut() {
    [[ -z "$@" ]] && return 1
    grepit "$@" | cut -c 1-350 | grep --color "$@"
}

grepit-ba1() {
    [[ -z "$@" ]] && return 1
    grepit -B 1 -A 1 "$@"
}

grepit-ba3() {
    [[ -z "$@" ]] && return 1
    grepit -B 3 -A 3 "$@"
}

grepit-ba5() {
    [[ -z "$@" ]] && return 1
    grepit -B 5 -A 5 "$@"
}

grepit-ba9() {
    [[ -z "$@" ]] && return 1
    grepit -B 9 -A 9 "$@"
}

grepit-logs() {
    findit . --exclude_dirs "venv, env, build, dist, .cache, .git" --ipattern "*.log" --pipesort "grep -Hn --color $@"
}

grepit-no-docs() {
    grepit --exclude=\*.{txt,md,rst,log} --exclude-dir=\*.dist-info "$@"
}

grepit-exact() {
    pattern=$1
    [[ -z "$pattern" ]] && return 1
    shift
    grepit "\b$pattern\b" "$@"
}

grep-object-info() {
    object="$1"
    [[ -z "$object" ]] && return 1
    grepit-no-docs "\b$object\b" | egrep -o "($object\(|$object(\.\w+)+\(?)" |
    sort | uniq -c | sort -nr | egrep -v '.(js|py)$'
}

grep-history() {
    grep -Hn --color "$@" ~/.*history*
}

grep-history-exact() {
    pattern=$1
    [[ -z "$pattern" ]] && return 1
    shift
    grep-history "\b$pattern\b" "$@"
}

history-comments() {
    grep-history "^#"
}
