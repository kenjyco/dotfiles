[[ -f "$HOME/.grip/bin/grip" ]] && alias grip="$HOME/.grip/bin/grip"

grip-many() {
    dirname=$1
    if [[ ! -z "$dirname" ]]; then
        shift
        if [[ ! -d "$dirname" ]]; then
            echo "$dirname is not a directory" >&2
            return 1
        fi
    else
        echo "No directory specified" >&2
        return 1
    fi

    echo "$dirname" > GENERATED-README.md
    eval "_find $dirname --pattern '*.md' $@" | xargs -d \\n -I {} echo '- [{}]({})' \
        | sort | grep -v 'GENERATED-README' >> GENERATED-README.md
    grip GENERATED-README.md "0.0.0.0:7777"
    rm GENERATED-README.md
}

install-grip() {
    virtualenv --no-site-packages $HOME/.grip
    $HOME/.grip/bin/pip install grip
}
