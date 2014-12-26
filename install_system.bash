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

# Install the packages
echo -e "\nsudo apt-get install..."
sudo apt-get install -y vim git zsh tmux curl pmount acpi diffstat colordiff htop tree ranger
sudo apt-get install -y openssh-server binutils-multiarch python-dev python-pip
# sudo apt-get install -y wodim dvd+rw-tools
# sudo apt-get install -y xserver-xorg-input-synaptics xserver-xorg-video-nouveau guvcview
# sudo apt-get install -y xserver-xorg-input-wacom
sudo apt-get install -y xserver-xorg-core xserver-xorg-input-kbd xserver-xorg-video-intel
sudo apt-get install -y xinit xclip xbindkeys awesome
sudo apt-get install -y gtypist typespeed cmatrix enscript
sudo apt-get install -y rxvt-unicode-256color feh scrot imagemagick emelfm2
sudo apt-get install -y wireless-tools wicd-curses wicd-daemon firmware-b43-installer
sudo apt-get install -y moc alsa-base alsa-utils alsa-firmware-loaders alsa-tools libav-tools
sudo apt-get install -y chromium-browser firefox pepperflashplugin-nonfree
sudo apt-get install -y recordmydesktop vlc audacity gimp evince-gtk
sudo apt-get install -y xscreensaver xscreensaver-data xscreensaver-data-extra xscreensaver-gl xscreensaver-gl-extra
# sudo apt-get install -y libreoffice wine virtualbox
sudo apt-get install -y libpq-dev postgresql postgresql-contrib
sudo apt-get install -y libxml2 libxslt1.1 libxml2-dev libxslt1-dev zlib1g-dev
sudo apt-get install -y libqt4-dev libqtwebkit-dev qt4-qmake build-essential xvfb

# Install Python virtualenv
sudo pip install virtualenv

# Install Flash plugin to browser(s)
sudo update-pepperflashplugin-nonfree --install

# Add user to the audio and video groups
user=$(whoami)
sudo usermod -a -G audio,video $user
