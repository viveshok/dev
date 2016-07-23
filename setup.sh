#!/bin/bash

# swap escape and caps lock key
setxkbmap -option caps:swapescape

## set blue background
xsetroot -solid midnightblue

# home setup
xrandr --output VGA1 --auto --right-of LVDS1

## office setup
### set up first screen
#xrandr --newmode "2560x1600_60"  348.16  2560 2752 3032 3504  1600 1601 1604 1656  -HSync +Vsync
#xrandr --delmode VBOX0 2560x1600_60
#xrandr --addmode VBOX0 2560x1600_60
#xrandr --auto --output VBOX0 --mode 2560x1600_60 --left-of VBOX1
#
### set up second screen
#xrandr --newmode "1920x1200_60"  193.16  1920 2048 2256 2592  1200 1201 1204 1242  -HSync +Vsync
#xrandr --delmode VBOX1 1920x1200_60
#xrandr --addmode VBOX1 1920x1200_60
#xrandr --auto --output VBOX1 --mode 1920x1200_60 --right-of VBOX0
#
