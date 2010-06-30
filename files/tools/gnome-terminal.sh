#!/bin/sh
# Usage: $0 [command]
pgrep -u "$USER" gnome-terminal | grep -qvx "$$"
if [ "$?" -eq 0 ]; then
  WID=`xdotool search --class "gnome-terminal" | head -1`
  xdotool windowactivate $WID
  xdotool key ctrl+shift+t
  
  sleep .1
  # You could use, instead of this clipboard hack:
  # xdotool type "$1"
  # xdotool key Return

  # save old clipboard value
  oldclip="$(xclip -o)"
  
  if [ "$#" -ne 0 ] ; then
    # Use copy+paste to write the command to the shell. This is
    # slightly more reliable than 'xdotool type'
    echo "exec sh -c '$*'" | xclip -i 
    xdotool key shift+Insert
  fi

  # Restore old clipboard value
  echo "$oldclip" | xclip -i
else
  /usr/bin/gnome-terminal -e "sh -c '$*'"
fi
