grepit() {
    [[ -z "$@" ]] && return 1
    grep -Hn --color -R --exclude=\*.{pyc,swp,min.js} --exclude-dir=venv --exclude-dir=env --exclude-dir=node_modules --exclude-dir=.git $@ \.
}

grepit-logs() {
    findit . --complex "-not \( -path '*/venv/*' -o -path '*/env/*' \
        -o -path '*/build/*' -o -path '*/.git/*' -prune \) -iname '*.log'" \
        --pipesort "grep -Hn --color $@"
}

grepit-no-docs() {
    grepit --exclude=\*.{txt,md,rst,log} --exclude-dir=\*.dist-info $@
}

grepit-exact() {
    pattern=$1
    [[ -z "$pattern" ]] && return 1
    shift
    grepit -p "\b$pattern\b" $@
}

grep-object-info() {
    object="$1"
    [[ -z "$object" ]] && return 1
    grepit-no-docs -p "\b$object\b" | egrep -o "($object\(|$object(\.\w+)+\(?)" |
    sort | uniq -c | sort -nr | egrep -v '.(js|py)$'
}

grep-history() {
    grep -Hn --color $@ ~/.*history*
}

grep-history-exact() {
    pattern=$1
    [[ -z "$pattern" ]] && return 1
    shift
    grep-history -p "\b$pattern\b" $@
}
