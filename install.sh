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
ls /usr/bin | grep -w "nano" || (xbps-install -S && xbps-install -y nano)
nano mirrorlist
REPO=$(cat mirrorlist | grep -v '#')
ARCH=x86_64-musl
XBPS_ARCH=$ARCH xbps-install -Sy -r /mnt -R $REPO'current/musl/' base-system
xbps-install -SyuR $REPO'current/musl/'
ls /usr/bin | grep -w "efibootmgr" || xbps-install -y efibootmgr
ls /usr/bin | grep -w "sed" || xbps-install -y sed
ls /usr/bin | grep -w "grep" || xbps-install -y grep
clear
echo "set your bootloader
1) grub
2) efistub"
read answr5
[ "$answr5" == "2" ] && (touch right && cp right /mnt)
mount --rbind /sys /mnt/sys
mount --make-rslave /mnt/sys
mount --rbind /dev /mnt/dev
mount --make-rslave /mnt/dev
mount --rbind /proc /mnt/proc
mount --make-rslave /mnt/proc
cp /etc/resolv.conf /mnt/etc/
cp userland.sh /mnt
mkdir -p /mnt/etc/xbps.d
echo "repository=$REPO'current/musl'" | cat >> /mnt/etc/xbps.d/00-repository-main.conf
cp de.sh /mnt
chroot /mnt bash userland.sh
rm /mnt/userland.sh
ls | grep -w "right" && bash efi.sh
ls /mnt | grep -w "right" && rm /mnt/right
rm /mnt/de.sh
