#!/bin/bash

set -e

# for external disk

# sudo fdisk -l # to find nanme /dev/xxx of disk to mount
sudo mount -t ntfs /dev/sdb1 /media/external

rsync -avr --delete /home/abeaulne/data /media/external/

sudo umount /media/external # before you disconnect

# for amazon S3

echo 'DRY RUN'

aws s3 sync --dryrun data s3://abeaulne-backup/data --size-only

read -p "\n\nCarry on? y/[n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    aws s3 sync data s3://abeaulne-backup/data --size-only
fi
