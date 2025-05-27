#!/bin/bash

battery_status=$(cat /sys/class/power_supply/BAT1/status)
battery_capacity=$(cat /sys/class/power_supply/BAT1/capacity)

if [ "$battery_status" == "Full" ] || [ "$battery_capacity" == "99" ]; then
    echo "Full"
else 
    echo "${battery_capacity}%"
fi
