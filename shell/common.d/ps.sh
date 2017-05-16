alias p="ps -eo user,pid,ppid,tty,cmd:200 | grep -v ' \['"
alias pa="ps -eo user,pid,ppid,tty,cmd:200"
alias psome="p | egrep -v '(chromium|firefox|zsh|cinnamon|ssh-agent|kdeinit|dbus-launch|avahi-daemon|syndaemon|nemo|nm-applet|sshd|tmux|urxvt|\/usr\/|\/lib\/|\/sbin\/)'"
