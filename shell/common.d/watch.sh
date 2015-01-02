alias watchit="watch -n 10 -t"
alias wbattery="watchit -d acpi"
alias wfortune="watchit fortune"
alias wpartitions="watchit eval \"lsblk -o name,size,type,mountpoint | grep 'part' | sort -k2 -h\""
