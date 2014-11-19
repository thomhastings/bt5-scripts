#!/bin/bash
function script_info()
{
##~~~~~~~~~~~~~~~~~~~~~~~~~ File and License Info ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Filename: iso_mod.sh
## Copyright (C) <2011>  <Snafu>

##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.

##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.

##  You should have received a copy of the GNU General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##_____________________________________________________________________________##
## I consider any script/program I write to always be a work in progress.  Please send any tips/tricks/streamlining ideas/comments/kudos via email to will@configitnow.com

## Comments written with a triple # are notes to myself, please ignore them.

## Colorsets ##
## echo -e "\033[1;32m = Instructions
## echo -e "\033[1;33m = Outputs
## echo -e "\033[34m   = WTFs
## echo -e "\033[1;34m = Headers
## echo -e "\033[36m   = Inputs
## echo -e "\033[31m   = Warnings / Infinite Loops
##_____________________________________________________________________________##


##~The Following Required Programs Must be in Your Path for Full Functionality~##
## This was decided as the de facto standard versus having the script look in locations for the programs themselves with the risk of them not being there.  Odds favor that they will be in /usr/bin or some other location readily available in your path...
## squashfs-tools
## genisoimage
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Requested Help ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Confirmation of usage for systems not listed in the Development Notes section.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~ Planned Implementations ~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ To Do ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Create default mksquashfs option based prior to Zero_Chaos implementation of kickass SQUASH method
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~ Development Notes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## I claim nothing on the creation of this script.  It is a script I found floating around on the Back|Track Forums.  That script had an error on it that I fixed, and have since been using everytime I modify/update my personal copies of Linux.  I hope that users everywhere will implement this script when they decide to modify/update their own personal copy of Linux.

## Modified the script to point all changes to $(pwd)/mod from the directory iso_mod.sh is launched in
## This made for much easier cleanup

## The burn to disc option and deletion of files that are created during the modifications to the original .iso have been disregarded.  They could have been implemented, however it was decided against for simplicity purposes.

## On 24 March 2012, this script was redesigned so that it could be used to customiZe other *nix systems.
## Look for #### MODIFY within this script to determine what you should customiZe for your specific distro.
## Confirmed to work on:
## Back|Track 5 r1
## Back|Track 5 r2
## Linux Mint 12 (64-bit)

## On 25 February 2013, I released a new version that allowed for simple pauses in the umounting process.
## This eliminated umount errors and made me a more happy camper....
## I also added my function for pretty colors called envir--()
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Bug Traq ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~ Credits and Kudos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## First and foremost, to God above for giving me the abilities I have, Amen.

## The "Community" for always working towards improving the existing.....

## Kudos to my wife for always standing by my side, having faith in me, and showing the greatest of patience for my obsession with hacking.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
read
}

##~~~~~~~~~~~~~~~~~~~~~~~~ BEGIN Repitious Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~##
envir--()
{
WRN="\033[31m"   ## Warnings / Infinite Loops
INS="\033[1;32m" ## Instructions
OUT="\033[1;33m" ## Outputs
HDR="\033[1;34m" ## Headers
INP="\033[36m"   ## Inputs
}

usage--()
{
clear
echo -e "\033[1;34m\nModify a Linux ISO:\033[1;32m ./iso_mod.sh -d <ISO>\n\n"
exit 1
}
##~~~~~~~~~~~~~~~~~~~~~~~~~ END Repitious Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~ BEGIN Starting Function ~~~~~~~~~~~~~~~~~~~~~~~~~~##
greet--()
{
clear
echo -e "\033[1;34m\n\n\n\n\n\n\n
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           Linux ISO Modification Script
      Author: Snafu ----> will@configitnow.com
           Read Comments Prior to Usage
           Version \033[1;33m$current_ver {Beta}\033[1;34m (\033[1;33m$rel_date\033[1;34m)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
sleep 2.5
}

launch--()
{
clear
echo -e "\033[1;34m
##################################################################################\033[1;33m
Path of chroot environment: $(pwd)/mod/edit\033[1;34m
##################################################################################
##################################################################################
[*] Linux ISO Modification Script
[*] Setting up the build environment..."

## Removed.  The end-user should determine which services they may or may not want autostarting at boot.
# services="inetutils-inetd tinyproxy iodined knockd openvpn atftpd ntop nstxd nstxcd apache2 sendmail atd dhcp3-server winbind miredo miredo-server pcscd wicd wacom cups bluetooth binfmt-support mysql"

## Mounting the ISO
mkdir -p mod/mnt
mount -o loop $isoname mod/mnt/
if [ $? -ne 0 ];then
	echo -e "\033[31m\nYOU MUST USE A VALID .ISO FOR THIS SCRIPT\n"
	sleep 1
	rm -rf mod
	exit 1
fi

mkdir -p mod/extract-cd
rsync --exclude=/casper/filesystem.squashfs -a mod/mnt/ mod/extract-cd
mkdir -p mod/squashfs
mount -t squashfs -o loop mod/mnt/casper/filesystem.squashfs mod/squashfs
mkdir -p mod/edit
echo -e "\033[1;33m[*] Creating file system, please wait ... "

## Making some files
cp -a mod/squashfs/* mod/edit/ 
cp /etc/resolv.conf mod/edit/etc/
cp /etc/hosts mod/edit/etc/
cp /etc/fstab mod/edit/etc/
cp /etc/mtab mod/edit/etc/
mount --bind /dev/ mod/edit/dev
mount -t proc /proc mod/edit/proc
echo -e "\033[1;34m##################################################################################\033[1;33m
[*] Entering livecd.\033[1;34m
##################################################################################\033[1;32m
[*] If you are running a large update, you might need to stop
[*] services like crond, udev, cups, etc in the chroot
[*] before exiting your chroot environment.\033[1;34m
##################################################################################\033[31m
[*] Ensure that you kill all external chroots for this script, prior to exiting\033[1;34m
##################################################################################\033[1;32m
[*] Once you have finished your modifications, type \"exit\"\033[1;34m
##################################################################################"
chroot mod/edit
## Now in chroot

## Initiated after the user has exited chroot
echo -e "\033[1;33m[*] Exited the build environemnt, unmounting images."
rm -rf mod/edit/etc/mtab
rm -rf mod/edit/etc/fstab

#### MODIFY BELOW
## Adjust this to fit your desired Operating System.  Presently set for Back|Track
echo "127.0.0.1	localhost
127.0.1.1	bt.foo.org	bt

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts" > mod/edit/etc/hosts
#### END MODIFY

echo "" > mod/edit/etc/resolv.conf

## We're gunna slow the below down just a bit, it results in less errors..
clear
umount mod/edit/dev
echo -e "$HDR\n\n\nTrying -->$OUT umount mod/edit/dev$HDR\n
If you receive an error saying it failed,$INS try it manually$HDR
If your attempt fails, wait 5 seconds and$INS retry$HDR
If the 2nd manual attempt fails,$INS you will probably be okay to proceed$HDR
After all, yer trapped in this script anyways,$WRN right?\n\n$INS
Press enter to continue"
read
clear
umount mod/edit/proc
echo -e "$HDR\n\n\nTrying -->$OUT umount mod/edit/proc$HDR\n
If you receive an error saying it failed,$INS try it manually$HDR
If your attempt fails, wait 5 seconds and$INS retry$HDR
If the 2nd manual attempt fails,$INS you will probably be okay to proceed$HDR
After all, yer trapped in this script anyways,$WRN right?\n\n$INS
Press enter to continue"
read
clear
umount mod/squashfs
echo -e "$HDR\n\n\nTrying -->$OUT umount mod/squashfs$HDR\n
If you receive an error saying it failed,$INS try it manually$HDR
If your attempt fails, wait 5 seconds and$INS retry$HDR
If the 2nd manual attempt fails,$INS you will probably be okay to proceed$HDR
After all, yer trapped in this script anyways,$WRN right?\n\n$INS
Press enter to continue"
read
clear
umount mod/mnt
echo -e "$HDR\n\n\nTrying -->$OUT umount mod/mnt$HDR\n
If you receive an error saying it failed,$INS try it manually$HDR
If your attempt fails, wait 5 seconds and$INS retry$HDR
If the 2nd manual attempt fails,$INS you will probably be okay to proceed$HDR
After all, yer trapped in this script anyways,$WRN right?\n\n$INS
Press enter to continue"
read
clear
## Hopefully slowing down the above, killed off the umount errors..

chmod +w mod/extract-cd/casper/filesystem.manifest
echo -e "\033[1;33m[*] Building manifest"
chroot mod/edit dpkg-query -W --showformat='${Package} ${Version}\n' > mod/extract-cd/casper/filesystem.manifest

## Removed
# for service in $services;do
# 	chroot mod/edit update-rc.d -f $service remove
# done

## The following statements should probably be removed?  If I understand this correctly, it will tell the system to remove the below upon installation of said ISO
# REMOVE='ubiquity casper live-initramfs user-setup discover xresprobe os-prober libdebian-installer4'
# for i in $REMOVE;do
# 	sed -i "/${i}/d" mod/extract-cd/casper/filesystem.manifest-desktop
# done

cp mod/extract-cd/casper/filesystem.manifest mod/extract-cd/casper/filesystem.manifest-desktop
sed -i '/ubiquity/d' mod/extract-cd/casper/filesystem.manifest-desktop
rm -rf mod/extract-cd/casper/filesystem.squashfs
echo -e "\033[1;33m[*] Building squashfs image..."
mksquashfs mod/edit mod/extract-cd/casper/filesystem.squashfs -b 1048576 -comp xz -no-recovery -noappend
rm mod/extract-cd/md5sum.txt
(cd mod/extract-cd && find . -type f -print0 | xargs -0 md5sum > md5sum.txt)
cd mod/extract-cd
echo -e "\033[1;33m[*] Creating iso ..."
mkisofs -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -V "ISO" -cache-inodes -r -J -l -o ../iso-mod.iso .
cd ../../
echo -e "\033[1;33m[*] Your modified ISO is $(pwd)/mod/iso-mod.iso\033[1;34m
##################################################################################"
exit 0
}
##~~~~~~~~~~~~~~~~~~~~~~~~~~ END Starting Function ~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~~~~ BEGIN Launch Conditions ~~~~~~~~~~~~~~~~~~~~~~~~~~~##
current_ver="1.2"
rel_date="25 February 2013"
envir--
if [ "$UID" -ne 0 ];then
	echo -e "\033[31mMust be ROOT to run this script"
	exit 87
fi

if [ $# -eq 0 ];then
	usage--
	exit 1
fi

while getopts ":d:" opt;do
	case "$opt" in
		d) isoname="$OPTARG"
		greet--
		launch--;;

		\?) usage--;;

		:) echo "Option -$OPTARG requires an argument."
		exit 1;;
	esac
done
##~~~~~~~~~~~~~~~~~~~~~~~~~ END Launch Conditions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
