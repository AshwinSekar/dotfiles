# Update settings
xrdb -merge .Xresources

# Background
wp change

# Include other font dirs
xset +fp /usr/share/fonts/adobe-source-code-pro
xset +fp ~/.fonts
xset fp rehash

# Stop sleep
xset -dpms s off
xset s off &
xset s noblank &

# Stop that godforsaken annoying beep
xset -b

# Activate BSPWM Window Manager
sxhkd & 2>~/.sxhkd.log
compton &
bottombar &

# Panel (also in /etc/profile)
[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"
exec bspwm W 2>~/.bspwm.log
