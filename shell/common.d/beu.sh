# Don't set anything in this file if `~/.beu_path` does not exist
[[ ! -f $HOME/.beu_path ]] && return 1
BEU_PATH="$(cat $HOME/.beu_path)"

beu() {
    cd $BEU_PATH
}

beu-ipython() {
    PYTHONPATH=$BEU_PATH $BEU_PATH/venv/bin/ipython $@
}
