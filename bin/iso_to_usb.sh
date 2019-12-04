#!/usr/bin/env bash
#
# Purpose: To write a bootable ISO image to a USB stick in (hidden) 2nd partition.
#
# Inspired by http://www.wgdd.de/2013/08/create-knoppix-usb-boot-stick-from.html
#
# Usage: ./iso_to_usb.sh /dev/sdb KNOPPIX_V7.2.0CD-2013-06-16-EN.iso

device=$1
if [[ ! -b "$device" ]]; then
    echo "Pass in path to block device (/dev/blah)" >&2
    exit 1
fi

image=$2
if [[ ! "$image" =~ .*.[Ii][Ss][Oo] ]]; then
    echo "Expected ISO file as 2nd argument" >&2
    exit 1
fi

# Complain if path to ISO goes through parent directory (via '../')
if [[ "$image" =~ \.\.\/ ]]; then
    echo "Specify absolute path to ISO file, don't use '../'"
    exit 1
fi

# Create absolute path to ISO
[[ ! "$image" =~ \/ ]] && image="$(pwd)/$image"

# Make sure the ISO exists
if [[ ! -s "$image" ]]; then
    echo "'$image' is empty or not found" >&2
    exit 1
fi

# Prompt to see if the device should be shredded first
read -p "Do you need to shred '$device' first? [y/n] " yn
if [[ "$yn" =~ [yY].* ]]; then
    echo -e "\ntime sudo shred -n 1 -z $device"
    time sudo shred -n 1 -z $device
fi

# Generate the isohybrid command, which requires knowing the HEADS and SECTORS
# of the block device (USB stick)
the_command=$(sudo fdisk -l $device 2>/dev/null |
    grep "sectors/track" |
    perl -pe 's/^(\d+) heads, (\d+) sectors\/track.*/isohybrid -o 1 -h $1 -s $2 -e 2/')

# HEAD info not provided by `fdisk -l` any more (from util-linux 2.27.1)
[[ -z "$the_command" ]] && the_command="isohybrid -o 1 -e 2"

# Execute the isohybrid command
the_command="$the_command $image"
echo -e "\n$the_command" >&2
eval "$the_command" || exit 1

# Copy the ISO image to the USB stick
echo -e "\ntime sudo sh -c \"cat $image > $device\"" >&2
time sudo sh -c "cat $image > $device"

# Show that the new hidden partition was created
echo -e "\nsudo fdisk -l $device"
sudo fdisk -l $device

# Start `fdisk` on the device to create a non-hidden partition
echo -e "\n--------------------------------------------------"
echo "'n' to create partition"
echo "'p' for 'primary'"
echo "'1' for partition 1 (one)"
echo "(select defaults for 'First sector' and 'Last sector')"
echo "'t' to change system type for partition"
echo "'1' to modify partition 1 (one)"
echo "'b' to use make FAT32 partition"
echo "'w' to write changes and exit"
sudo fdisk $device || exit 1
echo -e "\n--------------------------------------------------"

# Should probably validate the user's input, but whatev
read -p "What do you want to name your partition (ALLCAPS)? " label
echo -e "\nsudo mkfs.vfat -F 32 -n $label ${device}1"
sudo mkfs.vfat -F 32 -n $label ${device}1
