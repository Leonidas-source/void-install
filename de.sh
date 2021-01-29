#!/bin/bash
clear
echo "set your desktop environment
1) kde
2) xfce
3) gnome
4) mate
5) cinnamon"
read answr
[ "$answr" == "1" ] && (xbps-install -y kde5 dolphin mesa-dri kdegraphics-thumbnailers ffmpegthumbs && ln -s /etc/sv/sddm /etc/runit/runsvdir/default/)
[ "$answr" == "2" ] && (xbps-install -y xfce4 mesa-dri lxdm && ln -s /etc/sv/lxdm /etc/runit/runsvdir/default/)
[ "$answr" == "3" ] && (xbps-install -y dbus gnome gdm mutter mesa-dri && ln -s /etc/sv/gdm /etc/runit/runsvdir/default/ && ln -s /etc/sv/dbus /etc/runit/runsvdir/default/)
[ "$answr" == "4" ] && (xbps-install -y mesa-dri mate lxdm && ln -s /etc/sv/lxdm /etc/runit/runsvdir/default/)
[ "$answr" == "5" ] && (xbps-install -y mesa-dri lxdm cinnamon && ln -s /etc/sv/lxdm /etc/runit/runsvdir/default/)
