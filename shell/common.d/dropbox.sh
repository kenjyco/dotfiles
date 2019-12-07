get-dropbox() {
    if [[ ! -d "$HOME/.dropbox-dist" ]]; then
        oldpwd=$(pwd)
        cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
        ~/.dropbox-dist/dropboxd
        cd "$oldpwd"
    else
        ~/.dropbox-dist/dropboxd
    fi
}
