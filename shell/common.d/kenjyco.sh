# Don't set anything in this file if `~/.kenjyco_path` does not exist
[[ ! -f $HOME/.kenjyco_path ]] && return 1

KENJYCO_PATH="$(cat $HOME/.kenjyco_path)"

kenjyco() {
    cd $KENJYCO_PATH
}

k() {
    PYTHONPATH=$KENJYCO_PATH ${KENJYCO_PATH}/venv/bin/python -m kenjyco
}

vidsearch() {
    oldpwd=$(pwd)
    cdd ~/vidsearch
    PYTHONPATH=$KENJYCO_PATH ${KENJYCO_PATH}/venv/bin/python ${KENJYCO_PATH}/kenjyco/misc/vidsearch.py $@
    cd "$oldpwd"
}

websearch() {
    oldpwd=$(pwd)
    cdd ~/websearch
    PYTHONPATH=$KENJYCO_PATH ${KENJYCO_PATH}/venv/bin/python ${KENJYCO_PATH}/kenjyco/misc/websearch.py $@
    cd "$oldpwd"
}

listen() {
    PYTHONPATH=$KENJYCO_PATH ${KENJYCO_PATH}/venv/bin/python ${KENJYCO_PATH}/kenjyco/misc/listen.py $@
}

make-home-venv-with-kenjyco() {
    if [[ ! -d "$HOME/venv" ]]; then
        cd
        python3 -m venv venv && venv/bin/pip3 install wheel
        venv/bin/pip3 install -r ${KENJYCO_PATH}/requirements.txt --upgrade
        venv/bin/pip3 install flake8 grip jupyter redis-helper mocp
        python3 -m venv --system-site-packages venv
    fi
}

upgrade-home-venv-with-kenjyco() {
    [[ ! -d "$HOME/venv" ]] && echo "$HOME/venv does not exist" && return 1
    cd
    venv/bin/pip3 install -r ${KENJYCO_PATH}/requirements.txt --upgrade
    venv/bin/pip3 install flake8 grip jupyter redis-helper mocp --upgrade
}
