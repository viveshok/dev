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

## docker howto build, distribute and run image/container from dockerfile
~~~~
$ cd dev/
$ docker build --tag="abeaulne/abeaulne" .
$ docker login
$ docker push abeaulne/abeaulne
$ docker run -i -t abeaulne/abeaulne
~~~~

