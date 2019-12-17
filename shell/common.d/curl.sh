weather-now() {
    location=$1
    # See https://github.com/chubin/wttr.in#one-line-output for output options
    curl "https://wttr.in/${location}?format='%c+%C+%t+%w+%p'"
}

weather-forecast() {
    location=$1
    curl "https://wttr.in/${location}"
}

news-help() {
    curl getnews.tech/:help
}

news-search() {
    query=$1
    [[ -z "$query" ]] && return 1
    curl -s "us.getnews.tech/${query},n=50,reverse" | less -rFX
}

news-cat-business() {
    curl -s "us.getnews.tech/category=business,n=50,reverse" | less -rFX
}

news-cat-entertainment() {
    curl -s "us.getnews.tech/category=entertainment,n=50,reverse" | less -rFX
}

news-cat-general() {
    curl -s "us.getnews.tech/category=general,n=50,reverse" | less -rFX
}

news-cat-health() {
    curl -s "us.getnews.tech/category=health,reverse,n=50,reverse" | less -rFX
}

news-cat-science() {
    curl -s "us.getnews.tech/category=science,n=50,reverse" | less -rFX
}

news-cat-sports() {
    curl -s "us.getnews.tech/category=sports,n=50,reverse" | less -rFX
}

news-cat-health() {
    curl -s "us.getnews.tech/category=health,n=50,reverse" | less -rFX
}
