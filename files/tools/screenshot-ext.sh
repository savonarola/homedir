#!/bin/bash
public_dir="${HOME}/Dropbox/Public/"
screensot_dir="Screenshots/"
fname=$(perl -MPOSIX -le '$rnd = `pwgen -1`; chomp $rnd;  print strftime("%Y%m%d-%H%M%S-screenshot-$rnd.png", localtime)')
mv $1 "${public_dir}${screensot_dir}${fname}"
curl "http://is.gd/api.php?longurl=http://dl.dropbox.com/u/2514655/${screensot_dir}${fname}" 2>/dev/null | xsel -i -b

