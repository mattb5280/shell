#!/bin/sh

# Shell script for ZCU208 SD card.
# Swaps between 2 sets of boot files.

img1="rfsocX_boot"
img2="hdlc208_boot"

# Ask user to pick boot image
echo Select boot image:
echo "  1 - $img1"
echo "  2 - $img2"
read -p '>> ' usr_sel


# Enforce integer input
case ${usr_sel#[-+]} in
  *[!0-9]* | '') 
     echo "Invalid input" 
     exit 1 ;;
  1) folder=$img1 ;;
  2) folder=$img2 ;;
  *) echo Invalid input
     exit 1 ;;
esac

echo Removing old boot files from root dir ...

rm -rf autostart.sh
rm -rf BOOT.BIN
rm -rf Image
rm -rf boot.scr
rm -rf build.txt
rm -rf devicetree.dtb
rm -rf hdlcoder_rd
rm -rf interfaces
rm -rf rf_init.log
rm -rf rootfs.cpio.gz.u-boot
rm -rf image.ub
rm -rf sshkeys
rm -rf system.bit
rm -rf uboot.env

echo Copying $folder files to root dir ...
cp -a ./$folder/* ./

echo New SD card root dir:
ls -w 1 --color=auto

echo 

read -p 'Reboot now? [y/n]: ' yesno
case ${yesno,,} in
  *[0-9]* | '') echo Invalid input ;;
  y) echo Rebootng!
     reboot ;;
  n) echo File swap done!  ;;
  *) echo You chose something weird. Do Nothing! ;;
esac
