#!/bin/bash
format() {
  clear
  echo "set filesystem
  1) ext4
  2) btrfs
  3) ext3
  4) xfs"
  read answr2
  [ "$answr2" == "1" ] && mkfs.ext4 $drive2
  [ "$answr2" == "2" ] && extented_btrfs
  [ "$answr2" == "3" ] && mkfs.ext3 $drive2
  [ "$answr2" == "4" ] && mkfs.xfs $drive2
}
extented_btrfs() {
  clear
  mkfs.btrfs $drive2
	mkdir test
	mount $drive2 test
	btrfs subvolume create test/root
	btrfs subvolume set-default 256 test
	umount $drive2
}
format2() {
  clear
  echo "set filesystem
  1) fat32
  2) exfat"
  read answr4
  [ "$answr4" == "1" ] && mkfs.vfat $drive3
  [ "$answr4" == "2" ] && mkfs.exfat $drive3
}
clear
lsblk
echo "set drive"
read drive
cfdisk $drive
clear
lsblk
echo "set / partition"
read drive2
echo "format it?
1) yes
2) no"
read answr
[ "$answr" == "1" ] && format
mount $drive2 /mnt
clear
lsblk
echo "set /boot partition"
read drive3
echo "format it?
1) yes
2) no"
read answr3
[ "$answr3" == "1" ] && format2
mkdir /mnt/boot
mount $drive3 /mnt/boot
ls /usr/bin | grep -w "nano" || (xbps-install -S && xbps-install nano)
nano mirrorlist
REPO=$(cat mirrorlist | grep -v '#')
ARCH=x86_64-musl
XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R $REPO'current/musl/' base-system
mount --rbind /sys /mnt/sys
mount --make-rslave /mnt/sys
mount --rbind /dev /mnt/dev
mount --make-rslave /mnt/dev
mount --rbind /proc /mnt/proc
mount --make-rslave /mnt/proc
cp /etc/resolv.conf /mnt/etc/
cp userland.sh /mnt
chroot /mnt bash userland.sh
