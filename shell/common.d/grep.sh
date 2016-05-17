grepit() {
    grep -Hn --color -R --exclude=\*.{pyc,swp} --exclude-dir=venv --exclude-dir=env --exclude-dir=.git $@ \.
}
