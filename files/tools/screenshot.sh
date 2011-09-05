#!/bin/zsh
#scrot $HOME'/Dropbox/Public/Screenshots/%Y%m%d-%H%M%S-screenshot-'`pwgen -1`'.png' -e 'curl "http://api.bit.ly/shorten?version=2.0.1&longUrl=http://dl.dropbox.com/u/2514655/Screenshots/"$n"&login=motonarola&apiKey=R_bccf05f1512323e197afdbe41cba78eb"' 2>/dev/null | grep shortUrl | awk 'BEGIN{FS="\""; ORS=""}{print $4}' | xsel -b -i
#scrot -s $HOME'/Dropbox/Public/Screenshots/%Y%m%d-%H%M%S-screenshot-'`pwgen -1`'.png' -e 'curl "http://is.gd/api.php?longurl=http://dl.dropbox.com/u/2514655/Screenshots/"$n' 2>/dev/null | xsel -i -b
xml_grep --text_only '//original_image' <(scrot -s /tmp/imgur.png && curl --form key=a4ec53d0a3f09f034a6629767ea86e85 --form image=@/tmp/imgur.png 'http://imgur.com/api/upload.xml' -s) | xsel -i -b

