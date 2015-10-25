#!/bin/bash

set -e

# for external disk

# sudo fdisk -l # to find nanme /dev/xxx of disk to mount
sudo mount -t ntfs /dev/sdb1 /media/external

rsync -av --delete /home/abeaulne/ /media/external/backup/ >> /home/abeaulne/utils/backup.log

sudo umount /media/external # before you disconnect

# for remote server
rsync -avr --delete /home/abeaulne/data abeaulne@128.199.101.40:/home/abeaulne

