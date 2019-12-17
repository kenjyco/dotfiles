[[ $(uname) == 'Darwin' ]] && return

alias shutdown="sudo shutdown -h +0"
alias reboot="sudo reboot"
alias partitions2="sudo blkid"
alias sudoers="getent group sudo"
alias uninstall-hard="sudo apt-get purge --auto-remove -y"
alias local-machines192="sudo nmap -sS -p22,7777 192.168.1.0/24"
alias local-machines10="sudo nmap -sS -p22,7777 10.0.0.0/24"
alias ports-ipv4="sudo lsof -Pn -i4"
alias hardware="sudo lshw -short"
APT_SECURITY_ONLY="/etc/apt/sources.security.only.list"

make-security-only-list() {
    sudo sh -c "grep ^deb /etc/apt/sources.list | grep security > $APT_SECURITY_ONLY"
}

do-security-upgrades() {
   [[ ! -f $APT_SECURITY_ONLY ]] && make-security-only-list
   sudo apt-get update
   apt-get -s dist-upgrade -o Dir::Etc::SourceList=$APT_SECURITY_ONLY -o Dir::Etc::SourceParts=/dev/null |
   grep '^Inst' |
   cut -d' ' -f2 |
   sudo xargs apt-get install -y -o Dir::Etc::SourceList=$APT_SECURITY_ONLY
}

reload-mongo-apt-key() {
    [[ ! -f /usr/bin/apt-key ]] && return 1
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
    sudo apt-get update
}

set-hostname() {
    newhostname=$1
    if [[ -z "$newhostname" ]]; then
        echo "Expected the new hostname as first argument" >&2
        return 1
    fi
    sudo hostnamectl set-hostname $newhostname || return 1

    # Modify/append line of /etc/hosts to set `127.0.1.1 $newhostname`
    matched=$(grep 127.0.1.1 /etc/hosts)
    if [[ -z "$matched" ]]; then
        sudo sh -c "echo 127.0.1.1    $newhostname >> /etc/hosts"
    else
        sudo sh -c "sed -i \"/127.0.1.1/c\127.0.1.1    $newhostname\" /etc/hosts" 2>/dev/null
    fi

    echo -e "results of 'hostname' command:"
    hostname
    echo -e "\ncontents of '/etc/hostname' file:"
    cat /etc/hostname
    echo -e "\ngrep of '127.0.1.1' in '/etc/hosts' file:"
    grep 127.0.1.1 /etc/hosts
}

newuser() {
    username=$1
    if [[ -z "$username" ]]; then
        echo "Expected a username as first argument" >&2
        return 1
    fi

    # Create the user
    echo -e "\nsudo useradd -m -s $(which zsh) $username" >&2
    sudo useradd -m -s $(which zsh) $username || return 1

    # Add the user to groups
    if [[ "$2" == sudo ]]; then
        sudo usermod -a -G sudo,audio,video,plugdev,netdev $username
    else
        sudo usermod -a -G audio,video,plugdev,netdev $username
    fi

    # Add an empty zshrc file so zsh doesn't bug you on first login
    sudo touch /home/$username/.zshrc
    sudo chown $username:$username /home/$username/.zshrc

    # Set a password for the user
    echo -e "\nsudo passwd $username" >&2
    sudo passwd $username

    # Move into the user's home directory
    oldpwd=$(pwd)
    cd /home/$username

    # Clone repos
    sudo mkdir repos
    sudo chown $username:$username repos
    cd repos
    repos=(dotfiles)
    for repo in "${repos[@]}"; do
        echo -e "\nsudo -u $username git clone https://github.com/kenjyco/$repo" >&2
        sudo -u $username git clone https://github.com/kenjyco/$repo
    done

    # Set permissions for the user home directory
    sudo chmod 700 /home/$username

    # Return to previous directory (before "clone repos" step)
    cd "$oldpwd"
}

newusergit() {
    username=$1
    [[ -z "$username" ]] && username="git"
    sudo useradd -m -s $(which git-shell) $username || return 1
    sudo chmod 700 /home/$username
    sudo mkdir /home/$username/.ssh
    sudo chmod 700 /home/$username/.ssh
    sudo touch /home/$username/.ssh/authorized_keys
    sudo chmod 600 /home/$username/.ssh/authorized_keys
    sudo chown -R $username:$username /home/$username
    sudo tree /home/$username
    echo -e "\nAdd the '$username' user to the AllowUsers line of '/etc/ssh/sshd_config'"
}

purgeuser() {
    username=$1
    [[ -z "$username" ]] && return 1

    # Find out if the user is sure
    if [[ -n "$BASH_VERSION" ]]; then
        read -p "are you sure? [y/n] " yn
    elif [[ -n "$ZSH_VERSION" ]]; then
        vared -p "are you sure? [y/n] " -c yn
    fi

    [[ ! "$yn" =~ [yY].* ]] && return 1

    # Actually remove the user and their home directory
    echo -e "\nsudo deluser --remove-home $username" >&2
    sudo deluser --remove-home $username
}
