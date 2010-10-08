#!/bin/bash
display=`xrandr --prop | grep -v disconnected | grep connected | zenity --list --column Display --text "Choose primary display" --width 600 --height 200 | cut -d ' ' -f 1`

if [ "x$display" != "x" ]; then
    xrandr --output $display --primary	
fi
 
