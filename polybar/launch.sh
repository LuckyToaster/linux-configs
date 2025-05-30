#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
# polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar mybar 2>&1 | tee -a /tmp/polybar1.log & disown
sleep 1
wmctrl -r "Polybar" -b add,below

# set the power profile icon
profile=$(powerprofilesctl get)
if [[ "$profile" == "performance" ]]; then
    polybar-msg hook powerprofile 2
else
    polybar-msg hook powerprofile 1
fi

echo "Bar launched..."

