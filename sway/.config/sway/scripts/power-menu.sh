#!/bin/bash

# Power menu options
options="Lock\nLogout\nSuspend\nReboot\nShutdown"

# Show wofi menu and get selection
selected=$(echo -e "$options" | wofi --dmenu --prompt "" --width 200 --height 250 --columns 1 --hide-scroll --no-actions --style ~/.config/wofi/power-menu.css)

# Execute action based on selection
case $selected in
    Lock)
        swaylock
        ;;
    Logout)
        swaymsg exit
        ;;
    Suspend)
        systemctl suspend
        ;;
    Reboot)
        systemctl reboot
        ;;
    Shutdown)
        systemctl poweroff
        ;;
esac
