#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
xbacklight -set 15
slstatus &
# ~/src/dwmsss/dwmsss &
~/.config/zsh/scripts/keys
DISPLAY:=127.0.0.1:0
exec dwm
