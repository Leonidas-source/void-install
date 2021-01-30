#!/bin/bash
user() {
  clear
  echo "set name for user"
  read answr2
  useradd -m $answr2
  echo "set password for user"
  passwd $answr2
}
xbps-install -Syu
xbps-install -y mc wget unzip nano exfat-utils btrfs-progs
nano /etc/hostname
clear
echo "set root password"
passwd
echo "add another user?
1) yes
2) no"
read answr
[ "$answr" == "1" ] && user
echo "install DE?
1) yes
2) no"
read answr3
[ "$answr3" == "1" ] && bash de.sh
ls | grep -w "right" || (xbps-install grub-x86_64-efi && grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id="Void")
xbps-reconfigure -fa
