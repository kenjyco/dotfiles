System Setup Instructions
=========================
#### Install system programs

    % ./install_system.sh

#### Copy `/media/usbstick/ssh` to `~/.ssh`, fix permissions, and see whats inside

    % cp -a /media/usbstick/ssh ~/.ssh && chmod 700 && chmod 600 ~/.ssh/*
    % cd ~/.ssh && ls -l
    ...

> SSH keys need to be setup before git repo can be cloned using SSH.

#### Get dotfiles and install

    % git clone git@github.com:kenjyco/dotfiles ~/.dotfiles && cd ~/.dotfiles && bash setup.bash

#### Unmute audio (for first time)

    % alsamixer

Press 'm' to unmute

#### Setup wireless

    % sudo service wicd start
    % wicd-curses

#### Remove password requirement for using `sudo`

    % sudo visudo

Change

    %sudo   ALL=(ALL:All) ALL

to 
    %sudo   ALL=(ALL:All) NOPASSWD:ALL

#### Disable waiting for network connection at boot
Comment out any network interfaces that are not loopback (lo)

    % sudo vim /etc/network/interfaces

#### Disable laptop from sleeping on lid close

    % sudo vim /etc/systemd/logind.conf

Uncomment and modify the following line

    HandleLidSwitch=ignore

Restart `systemd-logind`

    % sudo restart systemd-logind

#### Disable MOTD for console login and SSH login
Edit the `pam.d/login` file

    % sudo vim /etc/pam.d/login

Comment out

    # session    optional   pam_motd.so  motd=/run/motd.dynamic noupdate
    # session    optional   pam_motd.so

Edit the `pam.d/sshd` file

    % sudo vim /etc/pam.d/sshd

Comment out

    # session    optional     pam_motd.so  motd=/run/motd.dynamic noupdate
    # session    optional     pam_motd.so # [1]
