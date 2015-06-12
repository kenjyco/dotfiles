alias shutdown="sudo shutdown -h +0"
alias reboot="sudo reboot"
alias partitions2="sudo blkid"
alias sudoers="getent group sudo"

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

    # Set a password for the user
    echo -e "\nsudo passwd $username" >&2
    sudo passwd $username

    # Clone dotfiles
    echo -e "\nsudo -u $username git clone https://github.com/kenjyco/dotfiles /home/$username/dotfiles" >&2
    sudo -u $username git clone https://github.com/kenjyco/dotfiles /home/$username/dotfiles

    # Make sure the new user owns all the stuff in their directory
    sudo chown -R $username:$username /home/$username/

    # Set permissions for the user home directory
    sudo chmod 700 /home/$username
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
