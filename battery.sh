#!/bin/bash

# spit out laptop battery info

upower -i /org/freedesktop/UPower/devices/battery_BAT0 |
    grep 'state\|time\ to\ full\|percentage\|temperature'

