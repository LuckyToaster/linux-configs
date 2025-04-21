#!/bin/bash

focused_info=$(i3-msg -t get_tree | jq '.. | select(.focused? == true)')
is_floating=$(echo "$focused_info" | jq -r '.floating')
app_instance=$(echo "$focused_info" | jq -r '.window_properties.instance')

if [[ "$is_floating" == "user_on" || "$is_floating" == "auto_on" ]]; then
    i3-msg 'floating disable; border none'
elif [[ "$app_instance" == "kitty" || "$app_instance" == "brave-browser" ]]; then
    i3-msg 'floating enable; border normal; resize set 1200 800; move position center'
else 
    i3-msg 'floating enable; border normal; move position center'
fi

