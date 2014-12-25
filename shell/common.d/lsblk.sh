alias partitions="lsblk -o name,size,type,mountpoint | grep 'part' | sort -k2 -h"
