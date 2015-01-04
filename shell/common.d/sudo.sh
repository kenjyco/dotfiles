alias shutdown="sudo shutdown -h +0"
alias reboot="sudo reboot"
alias partitions2="sudo blkid"

newuser() {
    username=$1
    [[ -z "$username" ]] && exit 1
    sudo useradd -m -s $(which zsh) $username
    sudo usermod -a -G audio,video,plugdev $username

    sudo -u $username git clone https://github.com/kenjyco/dotfiles /home/$username/.dotfiles
}
