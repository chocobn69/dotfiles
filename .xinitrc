[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
setxkbmap -layout us -variant altgr-intl -option nodeadkeys ctrl:nocaps
exec i3
