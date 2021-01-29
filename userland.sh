#!/bin/bash
xbps-install -Syu
xbps-install -y mc wget unzip nano
nano /etc/hostname
clear
echo "set root password"
passwd
ls | grep -w "right" || (xbps-install grub-x86_64-efi && grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id="Void")
xbps-reconfigure -fa
