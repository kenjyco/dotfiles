getmusic() {
    if [[ ! -d /music ]]; then
        echo "/music directory needs to be created"
        sudo mkdir -v /music || return 1
        sudo chmod 777 /music
        sudo chown -R $(whoami):$(whoami) /music
    fi

    cd /music
    youtube $1 --audio --description
    cd -
}
