#!/bin/bash
title="$1"
if [ "x$title" != "x" ]; then
    echo -e "\x1B]2;$title\x07"
fi
