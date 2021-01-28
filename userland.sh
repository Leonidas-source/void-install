#!/bin/bash
xbps-install -S 
xbps-install nano
nano /etc/hostname
echo "set root password"
passwd
xbps-install grub-x86_64-efi
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id="Void"
xbps-reconfigure -fa
