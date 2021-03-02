# two monitors setup

#xrandr --dpi 220 --output eDP --mode 2880x1800 \
#                 --output HDMI-0 --mode 1920x1080 --scale 2x2 --right-of eDP --panning 3840x2160+2880+0

xrandr --output eDP-1 --mode 1920x1080 \
       --output HDMI-2 --mode 1920x1080 --right-of eDP-1
