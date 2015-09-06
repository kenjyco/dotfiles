# Ex:
#   grip-many
#   grip-many . --depth 2
#   grip-many . --hours 5
grip-many() {
    dirname=$1
    if [[ -n "$dirname" ]]; then
        shift
    else
        dirname='.'
    fi

    if [[ ! -d "$dirname" ]]; then
        echo "$dirname is not a directory" >&2
        return 1
    fi

    echo "$dirname" > GENERATED-README.md

    # Generate a markdown file containing links to all the found markdown files
    eval "findit $dirname --complex \"\( -iname '*.md' -o -iname '*.idea' \)\" $@" |
    xargs -d \\n -I {} echo '- [{}]({})' |
    sort |
    grep -v 'GENERATED-README' >> GENERATED-README.md

    grip GENERATED-README.md "0.0.0.0:7777"
    rm GENERATED-README.md
}
