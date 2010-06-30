#!/bin/bash
ZRES=$(zenity --list --text="" --title="Custom Launcher" --width=600 --height=400  --column="Name" --column="Command" --print-column=ALL --separator=" "\
    jail                "ssh person-savonarola.corp"\
    person              "ssh nariel-colo20.person.com"\
)
if [ "$?" -eq 0 ] && [ "x$ZRES" != "x" ] ; then
    #echo "$ZRES";
    #sleep 10;
    gnome-terminal.sh $ZRES
fi
