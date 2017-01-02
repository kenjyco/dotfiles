# Don't set anything in this file if `~/.beu_path` does not exist
[[ ! -f $HOME/.beu_path ]] && return 1
BEU_PATH="$(cat $HOME/.beu_path)"

beu() {
    cd $BEU_PATH
}

beu-ipython() {
    PYTHONPATH=$BEU_PATH $BEU_PATH/venv/bin/ipython $@
}

beu-test() {
    PYTHONPATH=$BEU_PATH $BEU_PATH/venv/bin/py.test -vsx -rs --pdb $@ $BEU_PATH/tests
}

beu-example () {
    oldpwd=$(pwd)
    cd $BEU_PATH
    beu-ipython -i examples/events.py
    cd "$oldpwd"
}
