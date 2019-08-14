
# dev

Miscellaneous configs, script and utils for my DEV environment

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

## joining PDFs
```
$ gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=finished.pdf file1.pdf file2.pdf
```

## miscellaneous bash
```
$ find . -name "*.pyc" -delete # remove all files in subdirectories with extension pyc
$ sudo shutdown -time now # shutdown computer
$ ln -s real_path sym_path # create symbolic link
$ cat /proc/cpuinfo # find out about the machine CPUs
$ cat /proc/meminfo # find out about the machine RAM
$ df -h # get disk usage
$ du -h filename # get file or directory size
$ sudo modprobe -r psmouse # reset laptop trackpad
```

## Docker
```
$ docker build -f Dockerfile.datascience --tag="abeaulne/datascience" . # build an image from specified Dockerfile
$ docker login # login to dockerhub
$ docker push abeaulne/datascience # push an image to dockerhub
$ docker run -i -t IMAGE /bin/bash # launch a container in interative bash mode
$ docker run  --mount 'type=volume,src=<VOLUME-NAME>,dst=<CONTAINER-PATH>' # mirror volume in container
$ docker stop CONTAINER # stop container
$ docker exec -i -t CONTAINER /bin/bash # open a console in a running container
$ docker images # list local images
$ docker ps -a # list local containers
$ docker ps -aq | xargs docker rm # delete all local containers
$ docker rmi IMAGE # delete an image
$ docker attach CONTAINER # attach to running container
> Ctrl + p + Ctrl + q # if container was ran with docker run -i -t, then detach
```

## Anaconda
```
$ conda env list # list environments
$ conda create --name py27 python=2.7 anaconda # create an python 2.7 env called py27
$ conda remove --name ENV_NAME --all # remove an env
$ source activate ENV_NAME # change to (activate) an env
$ source deactivate # deactivate current env
```
