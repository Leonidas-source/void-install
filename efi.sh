#!/bin/bash
lsblk
echo "set your drive(not partition) with ESP"
read answr
lsblk $answr
echo "set number of that(ESP) partition (1,2,3,4)"
read answr2
clear
lsblk
echo "set / partition"
read answr3
answr4=$(lsblk -f $answr3 -o UUID | sed s/"UUID"/""/g | sed '/^$/d;s/[[:blank:]]//g')
vm=$(ls /mnt/boot | grep vmlinuz)
init=$(ls /mnt/boot | grep initramfs)
efibootmgr --disk $answr --part $answr2 --create --label "VOID" --loader  '/'$vm  --unicode 'root=UUID='$answr4' rw initrd=\'$init''
