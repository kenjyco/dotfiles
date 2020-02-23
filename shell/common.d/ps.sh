if [[ $(uname) == "Darwin" ]]; then
    alias p="ps aux | egrep -v '(^_|^root)'"
    alias pa="ps aux"
    alias psome="p | egrep -v '(ssh-agent|-bash$|/System/Library|/usr/libexec|/usr/sbin|SafeEjectGPUAgent|Google Chrome|/Applications/Slack.app|Applications/iTerm.app|Applications/Postman.app|Applications/Firefox.app|com\.docker\.)'"
else
    alias p="ps -eo user,pid,ppid,tty,cmd:200 | grep -v ' \['"
    alias pa="ps -eo user,pid,ppid,tty,cmd:200"
    alias psome="p | egrep -v '(chromium|firefox|zsh|cinnamon|ssh-agent|kdeinit|dbus-launch|avahi-daemon|syndaemon|nemo|nm-applet|sshd|tmux|urxvt|\/usr\/|\/lib\/|\/sbin\/)'"
fi
