#!/bin/bash
# capacity=$(cat /sys/class/power_supply/BAT1/capacity)
# status=$(cat /sys/class/power_supply/BAT1/status)
#
# if [[ "$status" == "Charging" ]]; then
#     echo "Charging ${capacity}%"
# elif [[ "$status" == "Discharging" ]]; then
#     echo "Discharging ${capacity}%"
# else
#     echo "Battery ${capacity}%"
# fi

#!/bin/bash

# Path to the battery status
battery_status=$(cat /sys/class/power_supply/BAT1/status)
battery_capacity=$(cat /sys/class/power_supply/BAT1/capacity)

# Check if the battery is charging, discharging, or full
if [ "$battery_status" == "Charging" ]; then
    echo "${battery_capacity}%"
elif [ "$battery_status" == "Discharging" ]; then
    echo "${battery_capacity}%"
elif [ "$battery_status" == "Full" ]; then
    echo "Full"
fi
