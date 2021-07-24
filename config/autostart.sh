#!/bin/bash
# If picom is running it means autostart script has already ran
# and we don't need to rerun the same apps again
if [[ -n $(pidof picom) ]]; then
    exit
fi

nm-applet --indicator &
xfce4-power-manager &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg &
blueman-applet &
volumeicon &
udiskie -ant &
