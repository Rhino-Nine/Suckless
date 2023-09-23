#!/usr/bin/sh

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors
. /home/rhino/.config/Suckless/dwm/scripts/bar_themes/dracula

cpu() {
   cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)
   printf "^c$black^ ^b$lightblue^  "
   printf "^c$white^ ^b$grey^ $cpu_val"
}

pkg_updates() {
  get_updates=$(checkupdates 2>/dev/null | wc -l) # arch
  printf "^c$black^ ^b$red^  "
  printf "^c$white^ ^b$grey^ $get_updates"
}

battery() {
  get_capacity="$(cat /sys/class/power_supply/BAT0/capacity)"
  printf "^c$black^ ^b$trueblue^  "
  printf "^c$white^ ^b$grey^ $get_capacity"
}

brightness() {
  get_brightness="$(cat /sys/class/backlight/*/brightness)"
  printf "^c$black^ ^b$orange^  "
  printf "^c$white^ ^b$grey^ $get_brightness"
}

volume() {
  get_volume="$(pamixer --get-volume-human)"
	printf "^c$black^ ^b$yellow^  "
	printf "^c$white^ ^b$grey^ $get_volume"
}

mem() {
  get_memory=$(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)
  printf "^c$black^ ^b$green^  "
  printf "^c$white^ ^b$grey^ $get_memory"
}

wlan() {
	case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
	up) printf "^c$blue^ 󰤨 ^d^%s";;
	down) printf "^c$red^ 󰤭 ^d^%s";;
	esac
}

clock() {
	printf "^c$black^ ^b$darkblue^   "
  printf "^c$black^^b$blue^ $(date '+%b/%d %a %R') "

}

while true; do
  [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
  interval=$((interval + 1))

  sleep 1 && xsetroot -name "  $updates $(brightness) $(volume) $(mem) $(cpu) $(battery) $(clock)"
done
