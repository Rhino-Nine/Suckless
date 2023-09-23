#!/usr/bin/sh
/home/rhino/.config/Suckless/dwm/scripts/bar.sh &
setbg &
xrdb merge /home/rhino/.config/x11/xresources &
xset r rate 350 50 &
xset mouse 1.3 &
xrander -s 1920x1080 &

# /home/rhino/.local/bin/cron/cleaner &
pulseaudio &
clash &
fcitx5 -D &
picom &
mpd &
# syncthing &
dunst &
brillo -S 100 &
pamixer -u --set-volume 30 &
# eww & 
# play-with-mpv &

while type dwm >/dev/null; do dwm && continue || break; done
