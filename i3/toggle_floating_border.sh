#!/bin/bash

is_floating=$(i3-msg -t get_tree | jq '.. | select(.focused? == true).floating')

if [[ "$is_floating" == "\"user_on\"" ]]; then
  i3-msg 'floating disable; border none'
else
  i3-msg 'floating enable; border normal'
fi
