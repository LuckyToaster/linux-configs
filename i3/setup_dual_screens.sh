#!/bin/bash

# Get the number of connected monitors
monitor_count=$(xrandr --listmonitors | grep -c "Monitors:")

# If there are 2 monitors, set workspace $ws0 to eDP-1
if [[ $monitor_count -eq 2 ]]; then
    xrandr --output HDMI-1 --auto --rotate normal --left-of eDP-1
    i3-msg "workspace \$ws10; output eDP-1"
fi
