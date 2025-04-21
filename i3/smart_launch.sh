#!/bin/bash 

CMD="$@"

nonfloating=$(node /home/lucky/.config/i3/num_non_floating_windows.js)

if [ "$nonfloating" -gt 0 ]; then
    i3-msg "exec --no-startup-id $CMD"
    sleep 0.5
    i3-msg '[con_mark="auto-float"] floating enable, border normal, resize set 1200 800, move position center'
else
    i3-msg "exec --no-startup-id $CMD"
fi
