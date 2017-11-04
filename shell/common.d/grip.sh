# Ex:
#   grip-many
#   grip-many . --depth 2
#   grip-many . --hours 5
grip-many() {
    _dirname=$1
    if [[ "$_dirname" =~ '--.*' ]]; then
        _dirname="."
    elif [[ -z "$_dirname" ]]; then
        _dirname="."
    else
        shift 2>/dev/null
    fi

    if [[ ! -d "$_dirname" ]]; then
        echo "$_dirname is not a directory" >&2
        return 1
    fi

    echo "$_dirname" > GENERATED-README.md

    # Generate a markdown file containing links to all the found markdown files
    eval "findit $_dirname --complex \"\( -iname '*.md' -o -iname '*.idea' \) -print0 \" $@" |
    xargs -0 -I {} echo '- [{}]({})' |
    sort |
    grep -v 'GENERATED-README' >> GENERATED-README.md

    grip GENERATED-README.md "0.0.0.0:7777"
    rm GENERATED-README.md
}
