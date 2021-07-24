#!/bin/bash
# Restart picom if it is not working
if [[ -z $(pidof picom) ]]; then
    picom --experimental-backends --config $HOME/.config/awesome/config/picom.conf &
fi

# If nm-applet is running it means autostart script has already ran
# and we don't need to rerun the same apps again
if [[ -n $(pidof nm-applet) ]]; then
    exit
fi

nm-applet --indicator &
xfce4-power-manager &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg &
blueman-applet &
volumeicon &
udiskie -ant &
