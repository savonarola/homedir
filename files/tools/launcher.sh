#!/bin/bash


ZRES=$(zenity --list --text="" --title="Custom Launcher" --width=600  --column="Name" --column="Command" --print-column=2\
    jail                "ssh person-savonarola.corp"\
    person              "ssh nariel-colo20.person.com"\
)
if [ "$?" -eq 0 ] && [ "x$ZRES" != "x" ] ; then
    gnome-terminal.sh $ZRES
fi
