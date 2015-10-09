getmusic() {
    if [[ ! -d /music/new ]]; then
        echo "/music/new directory needs to be created"
        sudo mkdir -pv /music/new || return 1
        sudo chmod 777 /music/new
        sudo chown -R $(whoami):$(whoami) /music/new
    fi

    cd /music/new
    youtube $1 --audio --description
    cd -
}
