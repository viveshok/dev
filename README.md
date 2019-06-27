# dev
Miscellaneous configs, script and utils for my DEV environment

* latexthat.sh <file.tex> triple-compile file.tex to get bibliography and
in-document references straight, then clean the destination folder of scruff
files and finally open the resulting PDF with evince
* backup.py picks files of predefined extensions in predefined directories
(and their subdirectories), zips them and finally sends the zipped archive
to your gmail account
* cheatsheet.html is yet another vim / xmonad / shell cheatsheet
* setup.sh adjust my laptop xmonad configuration to an external monitor

## network manager on debian

```
$ # list wifi networks:
$ nmcli dev wifi list
$ # connect to a new wifi network
$ nmcli dev wifi connect <NETWORK NAME/SSID> password <PASSWORD>
$ # connect to an existing wifi network
$ nmcli connection up id <NETWORK NAME/SSID>
$ # disconnect from an existing wifi network
$ nmcli connection down id <NETWORK NAME/SSID>
$ # show status:
$ nmcli c show
$ # delete an existing connection
$ nmcli connection delete <NETWORK NAME/SSID>
$ # restart network manager
$ sudo service network-manager restart
```

## setup OpenVPN

```
$ sudo vim /etc/default/openvpn
:%s/#AUTOSTART="all"/AUTOSTART="all"/g
$ sudo cp /location/whereYouDownloadedConfigfilesTo/Germany.ovpn /etc/openvpn/client.conf
$ sudo vim /etc/openvpn/client.conf
:%s/auth-user-pass/auth-user-pass pass/g
$ sudo vim /etc/openvpn/pass  # username first line, password second line
$ sudo chmod 400 /etc/openvpn/pass
$ sudo systemctl enable openvpn@client.service
$ sudo systemctl daemon-reload
$ sudo service openvpn@client start
```

## restarting OpenVPN

```
$ sudo systemctl stop openvpn@client
$ sudo systemctl start openvpn@client
$ sudo systemctl status openvpn@client
```

## changing keyboard layout

```
$ setxkbmap fr
$ setxkbmap us
```

## Reset trackpad

```
$ sudo modprobe -r psmouse
```

## formatting usb stick
```
$ lsblk
$ sudo mkfs -t vfat /dev/sdc1
```

## mounting usb stick

```
$ lsblk
$ sudo mkdir /media/usb/
$ sudo mount /dev/sdb1 /media/usb
$ sudo umount /media/usb
```

# joining PDFs
```
$ gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=finished.pdf file1.pdf file2.pdf
```
