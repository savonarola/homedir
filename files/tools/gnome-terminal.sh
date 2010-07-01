#!/bin/bash
# Usage: $0 [tab title] [command]
title=$1
shift
pgrep -u "$USER" gnome-terminal | grep -qvx "$$"
if [ "$?" -eq 0 ]; then
  WID=`xdotool search --class "gnome-terminal" | head -1`
  xdotool windowactivate $WID
  xdotool key ctrl+shift+t
  
  sleep .1
  # xdotool type "$1"
  # xdotool key Return

  oldclip="$(xclip -o)"
  
  echo "echo -e \"\\x1B]2;$title\\x07\"; $*" | xclip -i 
  xdotool key shift+Insert

  echo "$oldclip" | xclip -i
else
  gnome-terminal -e "$*" --title="$title"
fi
