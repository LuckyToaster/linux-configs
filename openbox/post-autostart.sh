#!/bin/bash

sleep 3 # slight delay

# KEYBOARD
# toggle keyboard layouts (shitty /etc/default/keyboard is shitty)
setxkbmap -layout "us,es" -option "grp:alt_shift_toggle"
xset r rate 150 40 &

# DISPLAYS
#xrandr --output HDMI-1 --auto --rotate normal --left-of eDP-1 &
set-display &
