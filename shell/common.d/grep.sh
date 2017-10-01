grepit() {
    grep -Hn --color -R --exclude=\*.{pyc,swp,min.js} --exclude-dir=venv --exclude-dir=env --exclude-dir=node_modules --exclude-dir=.git $@ \.
}

grepit-no-docs() {
    grepit --exclude=\*.{txt,md,rst,log} --exclude-dir=\*.dist-info $@
}
