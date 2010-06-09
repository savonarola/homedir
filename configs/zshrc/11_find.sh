f () { find ./ -name "$1" -print0 | xargs -0 egrep --line-number --with-filename --color "$2"  }
fn () { find ./ -name "$1" -print0 | xargs -0 egrep --line-number --with-filename --color "$2" | sed -e 's/:/ +/' }
fr () { find ./ -regextype posix-egrep -regex "$1" -print0 | xargs -0 egrep --line-number --with-filename --color "$2" }
ff () {find "$1" -name "$2" -exec egrep -Hn "$3" {} \;}
