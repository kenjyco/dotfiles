if [[ $(uname) == "Darwin" ]]; then
    alias dfh="df -lPh"
else
    alias dfh="df -Th --total | egrep -v '(^none|^udev|^tmpfs|^cgmfs)'"
fi
