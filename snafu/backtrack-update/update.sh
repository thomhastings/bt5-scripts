#!/bin/bash
function script_info--()
{
##~~~~~~~~~~~~~~~~~~~~~~~~~ File and License Info ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Filename: update.sh
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


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Requested Help ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Taking any suggestions on programs to be added to this script.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ To Do ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Add in functionality to check for the pre-existence of directories and ask the user if they would like to install.  This can come in handy if the user has removed a directory by accident, or for programs like hostmap and other programs like it to be added in the future to this script that are not included with Back|Track by default.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~ Development Notes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## $var is a recycled variable throughout the script

## On 7 January 2012, Eterm replaced xterm.  This is a much slicker program.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~ Planned Implementations ~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Creation of a Tail Log for successful updates; this will kill the need for --pause with Eterm && make the script that much slicker..

## Update all option from choices--()
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Bug Traq ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~ Credits and Kudos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## First and foremost, to God above for giving me the abilities I have, Amen.

## Kudos to my wife for always standing by my side, having faith in me, and showing the greatest of patience for my obsession with hacking.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
read
}

##~~~~~~~~~~~~~~~~~~~~~~~~ BEGIN Repitious Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~##
usage--()
{
clear
echo -e "\033[1;34m\nUpdate Back|Track \033[1;33m5\033[1;34m (\033[1;33mr2\033[1;34m):\033[1;32m ./update.sh\n"
}

progs--()
{

## Exploitz
	exploitdb--()
	{
	update_path=/pentest/exploits/exploitdb/
	if [[ $iso_mod == "true" ]];then
		Eterm -b black -f white --pause --title "ISO mod exploitdb updates" -e chroot $chrtpath svn up $update_path &
	else
		Eterm -b black -f white --pause --title "exploitdb updates" -e svn up $update_path &
	fi
	}

	fasttrack--()
	{
	update_path=/pentest/exploits/fasttrack
	jumpback=$(pwd) ## Directory to jumpback to after execution of updates.  Implemented for updates that must be executed IN that directory.
	if [[ $iso_mod == "true" ]];then
		cd $chrtpath/$update_path
		Eterm -b black -f white --pause --title "ISO mod fasttrack updates" -e ./fast-track.py -c 1 &
	else
		cd $update_path
		Eterm -b black -f white --pause --title "fasttrack updates" -e ./fast-track.py -c 1 &
	fi
	cd $jumpback
	}

	msf--()
	{
	update_path=/opt/metasploit/msf3
	if [[ $iso_mod == "true" ]];then
		Eterm -b black -f white --pause --title "ISO mod MSF updates" -e chroot $chrtpath svn up $update_path  &
	else
		Eterm -b black -f white --pause --title "MSF updates" -e svn up $update_path &
	fi
	}

	openvas--()
	{
	if [[ $iso_mod == "true" ]];then
		Eterm -b black -f white --pause --title "ISO mod openvas updates" -e chroot $chrtpath openvas-nvt-sync &
	else
		Eterm -b black -f white --pause --title "openvas updates" -e openvas-nvt-sync &
	fi
	}

	set--()
	{
	update_path=/pentest/exploits/set/
	if [[ $iso_mod == "true" ]];then
		Eterm -b black -f white --pause --title "ISO mod SET updates" -e chroot $chrtpath svn up $update_path &
	else
		Eterm -b black -f white --pause --title "SET updates" -e svn up $update_path &
	fi
	}

## HttP/s
	fimap--()
	{
	update_path=/pentest/web/fimap/fimap.py
	if [[ $iso_mod == "true" ]];then
		Eterm -b black -f white --pause --title "ISO mod fimap updates" -e chroot $chrtpath $update_path --update-def &
	else
		Eterm -b black -f white --pause --title "fimap updates" -e $update_path --update-def &
	fi
	}

	nikto--()
	{
	update_path=/pentest/web/nikto/
	if [[ $iso_mod == "true" ]];then
		Eterm -b black -f white --pause --title "ISO mod nikto updates" -e chroot $chrtpath svn up $update_path &
	else
		Eterm -b black -f white --pause --title "nikto updates" -e svn up $update_path &
	fi
	}

	w3af--()
	{
	update_path=/pentest/web/w3af/
	if [[ $iso_mod == "true" ]];then
		Eterm -b black -f white --pause --title "ISO mod w3af updates" -e chroot $chrtpath svn up $update_path  &
	else
		Eterm -b black -f white --pause --title "w3af updates" -e svn up $update_path &
	fi
	}

## Scan/Enum
	hostmap--()
	{
	update_path=/pentest/enumeration/dns/hostmap
	if [ -d $update_path ];then
		if [[ $iso_mod == "true" ]];then
			Eterm -b black -f white --pause --title "ISO mod hostmap updates" -e chroot $chrtpath svn up $update_path & host_pid=$!
			wait ${host_pid}
			chroot $chrtpath chmod 755 $update_path/hostmap.rb &
		else
			Eterm -b black -f white --pause --title "hostmap updates" -e svn up $update_path & host_pid=$!
			wait ${host_pid}
			chmod 755 $update_path/hostmap.rb &
			
		fi

	else
		if [[ $iso_mod == "true" ]];then
			Eterm -b black -f white --pause --title "ISO mod hostmap updates" -e chroot $chrtpath svn checkout http://svn.lonerunners.net/projects/hostmap/trunk $update_path & host_pid=$!
			wait ${host_pid}
			chroot $chrtpath chmod 755 $update_path/hostmap.rb &
		else
			Eterm -b black -f white --pause --title "hostmap updates" -e svn checkout http://svn.lonerunners.net/projects/hostmap/trunk $update_path & host_pid=$!
			wait ${host_pid}
			chmod 755 $update_path/hostmap.rb &
		fi

	fi
	}

## nmap update has been disabled until further research can be done.
# 	nmap--()
# 	{
# 	update_path=/usr/local/share/nmap/nmap-os-db
# 	if [[ $iso_mod == "true" ]];then
# 		Eterm -b black -f white --pause --title " ISO mod nmap OS DataBase updates" -e chroot $chrtpath wget http://nmap.org/svn/nmap-os-db -O $update_path &
# 	else
# 		Eterm -b black -f white --pause --title "nmap OS DataBase updates" -e wget http://nmap.org/svn/nmap-os-db -O $update_path &
# 	fi
# 	}

## SQLI

## The .deb for sqlmap that comes with BT5r2 has been found to properly svn up.  Maintaining the original code, but commenting out the non-needed stuff.
	sqlmap--()
	{
	update_path=/pentest/database/sqlmap
# 	if [ -d $update_path ];then
# 		var= ## Nulled
# 		while [ -z $var ];do
# 			echo -e "\033[36mIs your copy of sqlmap svn updateable?  (y or n)\033[31m  The copy that comes by default is not.\033[1;32m
# Answer (n) if unknown"
# 			read var
# 			case $var in
# 				y|Y) sqlmap_copy=good ;;
# 				n|N) sqlmap_copy=bad ;;
# 				*) var= ;; ## Nulled
# 			esac
# 		done
# 
# 		if [[ $sqlmap_copy == "good" ]];then
# 			if [[ $iso_mod == "true" ]];then
# 				Eterm -b black -f white --pause --title "ISO mod sqlmap updates" -e chroot $chrtpath svn up $update_path &
# 			else
# 				Eterm -b black -f white --pause --title "sqlmap updates" -e svn up $update_path &
# 			fi
# 
# 		else
# 			if [[ $iso_mod == "true" ]];then
# 				Eterm -b black -f white --pause --title "ISO mod sqlmap removal" -e chroot $chrtpath rm -rf $update_path & rem_pid=$!
# 				wait ${rem_pid}
# 				Eterm -b black -f white --pause --title "ISO mod sqlmap updates" -e chroot $chrtpath svn checkout https://svn.sqlmap.org/sqlmap/trunk/sqlmap $update_path &
# 			else
# 				Eterm -b black -f white --pause --title "sqlmap removal" -e rm -rf $update_path & rem_pid=$!
# 				wait ${rem_pid}
# 				Eterm -b black -f white --pause --title "sqlmap updates" -e svn checkout https://svn.sqlmap.org/sqlmap/trunk/sqlmap $update_path &
# 			fi
# 
# 		fi
# 
# 	else
		if [[ $iso_mod == "true" ]];then
			Eterm -b black -f white --pause --title "ISO mod sqlmap updates" -e chroot $chrtpath svn checkout https://svn.sqlmap.org/sqlmap/trunk/sqlmap $update_path &
		else
			Eterm -b black -f white --pause --title "sqlmap updates" -e svn checkout https://svn.sqlmap.org/sqlmap/trunk/sqlmap $update_path &
		fi

# 	fi
	}

## System Updates
	upt--()
	{
	case $upt_var in
		1) if [[ $iso_mod == "true" ]];then
			Eterm -b black -f white --pause --title " ISO mod apt-get updates" -e chroot $chrtpath apt-get update &
		else
			Eterm -b black -f white --pause --title "apt-get updates" -e apt-get update &
		fi;;

		2) if [[ $iso_mod == "true" ]];then
			Eterm -b black -f white --pause --title " ISO mod apt-get upgrades" -e chroot $chrtpath apt-get upgrade &
		else
			Eterm -b black -f white --pause --title "apt-get upgrades" -e apt-get upgrade &
		fi;;

		3) if [[ $iso_mod == "true" ]];then
			Eterm -b black -f white --pause --title " ISO mod apt-get updates" -e chroot $chrtpath apt-get dist-upgrade &
		else
			Eterm -b black -f white --pause --title "apt-get updates" -e apt-get dist-upgrade &
		fi;;

		4) if [[ $iso_mod == "true" ]];then
			Eterm -b black -f white --pause --title " ISO mod apt-get update" -e chroot $chrtpath apt-get update & upt_pid=$!
			wait ${upt_pid}
			Eterm -b black -f white --pause --title " ISO mod apt-get dist-upgrade" -e chroot $chrtpath apt-get upgrade &
		else
			Eterm -b black -f white --pause --title "apt-get dist-update" -e apt-get update & upt_pid=$!
			wait ${upt_pid}
			Eterm -b black -f white --pause --title "apt-get dist-upgrades" -e apt-get upgrade &
		fi;;

		5) if [[ $iso_mod == "true" ]];then
			Eterm -b black -f white --pause --title " ISO mod apt-get update" -e chroot $chrtpath apt-get update & upt_pid=$!
			wait ${upt_pid}
			Eterm -b black -f white --pause --title " ISO mod apt-get dist-upgrade" -e chroot $chrtpath apt-get dist-upgrade &
		else
			Eterm -b black -f white --pause --title "apt-get dist-update" -e apt-get update & upt_pid=$!
			wait ${upt_pid}
			Eterm -b black -f white --pause --title "apt-get dist-upgrade" -e apt-get dist-upgrade &
		fi;;
	esac
	}

## Telephony
	dedected--()
	{
	update_path=/pentest/telephony/dedected
	if [[ $iso_mod == "true" ]];then
		Eterm -b black -f white --pause --title "ISO mod dedected updates" -e chroot $chrtpath svn up $update_path &
	else
		Eterm -b black -f white --pause --title "dedected updates" -e svn up $update_path &
	fi
	}

## Warvox has been suspended until the .deb is fixed.  There is too much in the dpkg -i process to have a simple svn removal and svn co here.
# 	warvox--()
# 	{
# 	update_path=/pentest/telephony/warvox/
# 	if [[ $iso_mod == "true" ]];then
# 		Eterm -b black -f white --pause --title "ISO mod warvox updates" -e chroot $chrtpath svn up $update_path &
# 	else
# 		Eterm -b black -f white --pause --title "warvox updates" -e svn up $update_path &
# 	fi
# 	}

## WiFi
	aircrack--()
	{
	update_path=/pentest/wireless/aircrack-ng/
	update_path_II=/pentest/wireless/aircrack-ng/scripts/airodump-ng-oui-update
	jumpback=$(pwd)
	if [[ $iso_mod == "true" ]];then
		Eterm -b black -f white --pause --title "ISO mod aircrack-ng updates" -e chroot $chrtpath svn up $update_path & air_pid=$!
		wait ${air_pid}
		Eterm -b black -f white --pause --title "ISO mod aircrack-ng make" -e chroot $chrtpath make -C $update_path & air_pid=$!
		wait ${air_pid}
		Eterm -b black -f white --pause --title "ISO mod aircrack-ng make install" -e chroot $chrtpath make install -C $update_path & air_pid=$!
		wait ${air_pid}
		Eterm -b black -f white --pause --title "ISO mod airodump-ng OUI updates" -e chroot $chrtpath bash $update_path_II &
	else
		Eterm -b black -f white --pause --title "aircrack-ng updates" -e svn up $update_path & air_pid=$!
		wait ${air_pid}
		cd $update_path
		Eterm -b black -f white --pause --title "aircrack-ng make" -e make & air_pid=$!
		wait ${air_pid}
		Eterm -b black -f white --pause --title "aircrack-ng make install" -e make install & air_pid=$!
		wait ${air_pid}
		cd $jumpback
		Eterm -b black -f white --pause --title "airodump-ng OUI updates" -e bash $update_path_II &
	fi
	}

	airdrop--()
	{
	update_path=/pentest/wireless/aircrack-ng/scripts/airdrop-ng/
	jumpback=$(pwd)
	if [[ $iso_mod == "true" ]];then
		cd $chrtpath/$update_path
		Eterm -b black -f white --pause --title "ISO mod airdrop-ng OUI updates" -e ./airdrop-ng -u &
	else
		cd $update_path
		Eterm -b black -f white --pause --title "airdrop-ng OUI updates" -e ./airdrop-ng -u &
	fi
	cd $jumpback
	}
}

trap--()
{
echo -e "\033[31m\nPlease Exit Out of The Script Properly"
sleep 2
choices--
}
##~~~~~~~~~~~~~~~~~~~~~~~~~ END Repitious Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~~~~ BEGIN Starting Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~##
greet--()
{
clear
echo -e "\033[1;34m\n\n\n\n\n\n\n
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           Back|Track \033[1;33m5\033[1;34m (\033[1;33mr2\033[1;34m) Update Script
      Author: Snafu ----> will@configitnow.com
           Read Comments Prior to Usage
           Version \033[1;33m$current_ver\033[1;34m (\033[1;33m$rel_date\033[1;34m)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
sleep 2.5
pre_choices--
}
##~~~~~~~~~~~~~~~~~~~~~~~~~~ END Starting Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~ BEGIN main_menu-- functions ~~~~~~~~~~~~~~~~~~~~~~~~~~##
pre_choices--()
{
var= ## Nulled
while [ -z $var ];do
	echo -e "\033[36m\nWill you be pointing this script at the iso_mod.sh chroot environment? (y or n)"
	read var
	case $var in
		y|Y) iso_mod=true ;;
		n|N) iso_mod=false ;;
		*) var= ;;
	esac

done

if [[ $iso_mod == "true" ]];then
	def_chrtpath=$(pwd)/mod/edit
	var= ## Nulled
	while [ -z $var ];do
		echo -e "\033[36m\nIs\033[1;33m $def_chrtpath \033[36mthe path of the chroot environment? (y or n)"
		read var
		case $var in
			y|Y) chrtpath="$def_chrtpath" ;;
			n|N) chrtpath= ;; ## Nulled
			*) var= ;; ## Nulled
		esac
	done

	while [ -z $chrtpath ];do
		echo -e "\033[36m\nPath of chroot environment?"
		read chrtpath
	done
fi

choices--
}

choices--()
{
trap trap-- INT
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 -Back|Track r1 Update Choices-
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Exploitz

2) HttP/s

3) Scan/Enum

4) SQLI

5) System Updates

6) Telephony

7) WiFi

E)xit Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read var
case $var in
	1) exploitz--;;

	2) https--;;

	3) scans--;;

	4) sqli--;;

	5) sys--;;

	6) tele--;;

	7) wifi--;;

	e|E) cleanup--;;

	*) choices--
esac
}

cleanup--()
{
exit 0
}
##~~~~~~~~~~~~~~~~~~~~~~~~ END main_menu-- functions ~~~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~~~~ BEGIN choices-- functions ~~~~~~~~~~~~~~~~~~~~~~~~~##
exploitz--()
{
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~
 -Back|Track r1 Exploitz-
~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) exploitdb

2) fasttrack

3) MSF

4) openvas

5) SET

A)ll of the Above

P)revious Menu

E)xit Script
~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read var
case $var in
	1) exploitdb--;;

	2) fasttrack--;;

	3) msf--;;

	4) openvas--;;

	5) set--;;

	a|A) exploitdb--
	fasttrack--
	msf--
	openvas--
	set--;;

	p|P) choices--;;

	e|E) cleanup--;;
esac

case $var in
	1|2|3|4|5|a|A|*) exploitz--;;
esac
}

https--()
{
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~
 -Back|Track r1 HttP/s-
~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) fimap

2) nikto

3) w3af

A)ll of the Above

P)revious Menu

E)xit Script
~~~~~~~~~~~~~~~~~~~~~~~~\n"
read var
case $var in
	1) fimap--;;

	2) nikto--;;

	3) w3af--;;

	a|A) fimap--
	nikto--
	w3af--;;

	p|P) choices--;;

	e|E) cleanup--;;
esac

case $var in
	1|2|3|4|a|A|*) https--;;
esac
}

scans--()
{
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~
 -Back|Track r1 Scan/Enum-
~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) hostmap

P)revious Menu

E)xit Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read var
case $var in
	1) hostmap-- & ;;

# 	2) nmap--;;

# 	a|A) hostmap-- &
# 	nmap--;;

	p|P) choices--;;

	e|E) cleanup--;;
esac

case $var in
	1|2|a|A|*) scans--;;
esac
}

sqli--()
{
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~
 -Back|Track r1 SQLI-
~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) sqlmap

P)revious Menu

E)xit Script
~~~~~~~~~~~~~~~~~~~~~~\n"
read var
case $var in
	1) sqlmap--;;
	p|P) choices--;;
	e|E) cleanup--;;
esac

case $var in
	1|*) sqli--;;
esac
}

sys--()
{
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 -Back|Track r1 System Updates-
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) apt-get update

2) apt-get upgrade

3) apt-get dist-upgrade

4) apt-get update & upgrade

5) apt-get update & dist-upgrade

P)revious Menu

E)xit Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read var
case $var in
	1) upt_var="1" ;;

	2) upt_var="2" ;;

	3) upt_var="3" ;;

	4) upt_var="4" ;;

	5) upt_var="5" ;;

	p|P) choices--;;

	e|E) cleanup--;;
esac

case $var in
	1|2|3|4|5) upt--;;
esac

case $var in
	1|2|3|4|5|*) sys--;;
esac
}

tele--()
{
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~
 -Back|Track r1 Telephony-
~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) dedected

P)revious Menu

E)xit Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
read var
case $var in
	1) dedected--;;

# 	2) warvox--;;

# 	a|A) dedected--
# 	warvox--;;

	p|P) choices--;;

	e|E) cleanup--;;
esac

case $var in
	1|2|a|A|*) tele--;;
esac
}

wifi--()
{
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~
 -Back|Track r1 WiFi-
~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) aircrack-ng

2) airdrop-ng

A)ll of the Above

P)revious Menu

E)xit Script
~~~~~~~~~~~~~~~~~~~~~~\n"
read var
case $var in
	1) aircrack-- & ;;

	2) airdrop-- ;;

	a|A) aircrack-- & air_pid=$!
		wait ${air_pid}
		airdrop--;;

	p|P) choices--;;

	e|E) cleanup--;;
esac

case $var in
	1|2|a|A|*) wifi--;;
esac
}
##~~~~~~~~~~~~~~~~~~~~~~~~~~ END choices-- functions ~~~~~~~~~~~~~~~~~~~~~~~~~~##

##~~~~~~~~~~~~~~~~~~~~~~~~~ BEGIN Launch Conditions ~~~~~~~~~~~~~~~~~~~~~~~~~~~##
current_ver="1.0"
rel_date="10 March 2012"
if [ "$UID" -ne 0 ];then
	echo -e "\033[31mMust be ROOT to run this script"
	exit 87
fi

if [ -z $1  ]; then
	progs--
	greet--
else
	usage--
fi
##~~~~~~~~~~~~~~~~~~~~~~~~~ END Launch Conditions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##