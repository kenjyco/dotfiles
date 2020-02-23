get-terraform() {
    if [[ ! -f "$HOME/bin/terraform" ]]; then
        oldpwd=$(pwd)
        cd /tmp
        if [[ $(uname) == "Darwin" ]]; then
            wget https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_darwin_amd64.zip
            unzip terraform_0.11.8_darwin_amd64.zip -d "$HOME/bin"
        else
            wget https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip
            unzip terraform_0.11.8_linux_amd64.zip -d "$HOME/bin"
        fi
        cd "$oldpwd"
    fi
}
