grepit() {
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
