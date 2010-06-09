
# this one is very nice:
# cursor up/down look for a command that started like the one starting on the command line
function history-search-end {
    integer ocursor=$CURSOR

    if [[ $LASTWIDGET = history-beginning-search-*-end ]]; then
      # Last widget called set $hbs_pos.
      CURSOR=$hbs_pos
    else
      hbs_pos=$CURSOR
    fi

    if zle .${WIDGET%-end}; then
      # success, go to end of line
      zle .end-of-line
    else
      # failure, restore position
      CURSOR=$ocursor
      return 1
    fi
}
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey -e "${key[Up]}"  history-beginning-search-backward-end #cursor up
bindkey -e "${key[Down]}" history-beginning-search-forward-end  #cursor down
