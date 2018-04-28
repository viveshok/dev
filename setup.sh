#!/bin/bash

# set blue background
xsetroot -solid midnightblue

#xrandr --newmode "1920x1080_60"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
#xrandr --delmode HDMI-0 1920x1080_60
#xrandr --addmode HDMI-0 1920x1080_60
#xrandr --auto --output HDMI-0 --mode 1920x1080_60 --right-of eDP
#xrandr --output HDMI-0 --mode 1920x1081 --rate 60 --right-of eDP
xrandr --output DisplayPort-0 --mode 2560x1440 --rate 60 --right-of eDP

