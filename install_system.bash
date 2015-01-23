#!/usr/bin/env bash

# install_system.bash
# ===================
#
# This script will install the necessary system packages, useful after a fresh
# setup of Ubuntu Mini 14.04

# Quit this script if this is not an Apt based system (Arch support is coming)
echo -e "\napt-cache stats"
apt-cache stats 2>/dev/null
if [[ 0 -ne $? ]]; then
    echo "Currently, only for Apt based systems. Pacman support is coming."
    exit 1
fi

# Quit this script if unable to update the package list
echo -e "\nsudo apt-get update"
sudo apt-get update
if [[ 0 -ne $? ]]; then
    echo "Unable to update the package list."
    exit 1
fi

echo -e "\nsudo apt-get install..."
echo -e "\nEssential stuff"
sudo apt-get install -y vim git zsh tmux curl pmount acpi diffstat colordiff htop tree ranger
sudo apt-get install -y openssh-server rxvt-unicode-256color feh scrot imagemagick emelfm2
sudo apt-get install -y gtypist typespeed cmatrix elinks enscript vlock termsaver evince-gtk
# sudo apt-get install -y wodim dvd+rw-tools

echo -e "\nPython stuff"
sudo apt-get install -y binutils-multiarch python-dev python-pip
sudo pip install --upgrade pip
sudo pip install virtualenv

# echo -e "\nPostgreSQL stuff"
# sudo apt-get install -y libpq-dev postgresql postgresql-contrib

echo -e "Chrome, Firefox, Flash stuff"
sudo apt-get install -y chromium-browser firefox pepperflashplugin-nonfree
sudo update-pepperflashplugin-nonfree --install

echo -e "\nXorg stuff"
sudo apt-get install -y xserver-xorg-core xserver-xorg-input-kbd xserver-xorg-video-intel
sudo apt-get install -y xinit xclip xbindkeys awesome

# echo -e "\nT530 stuff"
# sudo apt-get install -y xserver-xorg-input-synaptics xserver-xorg-video-nouveau

# echo -e "\nArt stuff"
# sudo apt-get install -y xserver-xorg-input-wacom inkscape gimp

echo -e "\nScreensaver stuff"
sudo apt-get install -y xscreensaver xscreensaver-data xscreensaver-data-extra xscreensaver-gl xscreensaver-gl-extra

echo -e "\nWireless stuff"
sudo apt-get install -y wireless-tools wicd-curses wicd-daemon firmware-b43-installer
sudo service wicd start
wicd-curses

echo -e "\nAudio/Video stuff"
sudo apt-get install -y moc alsa-base alsa-utils alsa-firmware-loaders alsa-tools libav-tools
sudo apt-get install -y recordmydesktop guvcview vlc audacity
user=$(whoami)
sudo usermod -a -G audio,video $user
alsamixer

# echo -e "\nOffice, virtualbox, wine stuff"
# sudo apt-get install -y libreoffice wine virtualbox

# Get dotfiles and install
# git clone https://github.com/kenjyco/dotfiles ~/.dotfiles && bash ~/.dotfiles/setup.bash
# read -p "Change your name and email in ~/.gitconfig (press ENTER to continue)"
# vim ~/.gitconfig
