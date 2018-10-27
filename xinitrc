setxkbmap -layout us,ru -option 'grp:alt_shift_toggle,terminate:ctrl_alt_bksp'
xset r rate 200 50
xbindkeys -p
bash -c 'if [[ $(lsusb | grep PCPlay) ]]; then xmodmap -e "keycode 94 = Super_L"; fi'
bash -c 'if [[ $(xrandr | grep HDMI2\ connected) ]]; then xrdb -load ~/.Xresources.hdmi; else xrdb -load ~/.Xresources; fi'
#xrandr --output eDP1 --left-of HDMI2
#xrandr --output eDP1 --mode 1920x1080
#xrandr --output HDMI2 --mode 1440x900
#xrandr --output HDMI2 --primary

eval `ssh-agent`

exec ck-launch-session dbus-launch --sh-syntax --exit-with-session openbox-session

#exec ck-launch-session dbus-launch --sh-syntax --exit-with-session dwm &
#feh --bg-fill /home/nik/wallpaper/ae86_cut.jpg &
#xscreensaver -no-splash &
#/home/nik/src/dwm-6.1/dwm-statusbar-master/statusbar
