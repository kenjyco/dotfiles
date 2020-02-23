[[ $(uname) == "Darwin" ]] && return

alias partitions="lsblk -o name,size,type,mountpoint | egrep '(part|lvm)'"
alias partitions-by-size="lsblk -o name,size,type,mountpoint | grep 'part' | sort -k2 -h"
