#!/bin/bash
#_______________________________________________________________________
# Authors:    	phillips321 (matt@phillips321.co.uk)
#               Ion/ikoniaris (http://bruteforce.gr)
#		        Ari Davies  (kussic@chaos6.net)
#		        Rich Hicks  (http://about.me/R.Hicks)
# License:    	CC BY-SA 3.0
# Use:        	Brings existing tools on BackTrack5 to bleeding edge,
#		        adds missing security tools and other useful utilities.
# Website:   	www.phillips321.co.uk
#_______________________________________________________________________
version="4.6.1" #August/2012
# Changelog:
# v4.6.1 - Fixed Fern-Wifi-Cracker upgrade option
# v4.6 - Added Skype for Linux, moved tiger to apt-powered additions
# v4.5 - Added HTTrack Website Copier, fixed minor error with openoffice.org
# v4.4 - Added putty, eric python ide, openoffice.org
# v4.3 - Added Java JDK (default-jdk), RapidSVN (gui client for subversion)
# v4.2 - Added Absinthe (GUI tool for blind SQL injection)
# v4.1 - Added makeline function for output generation
# v4.0.1 - Added option to change the default MySQL's root password (toor)
#			Added hostmap (virtual hosts enumeration), VirtualBox 
#			Added missing ophcrack option, minor fixes
# v4.0 - ==> Now works with BT5r2 <==
# v3.1 - Added nessus to installs
# v3.0 - Many bug fixes (thanks Ion - http://bruteforce.gr/)
#			Fixed w3af bug (missing dependencies pybloomfiltermap)
#			Fixed warvox svn relocation issue
#			Removed hydra svn and replaced with bt repo hydra (7.2)
#			Added adobe reader install option
#			Fixed typo in update router defence
# v2.8 - Added tsocks (tsocks openssl s_client -connect www.target.com:443)
# v2.71 - Fixed nmap issues with updating.
# v2.7 - Added tool to get missing repo keys, unetbootin and parcellite. Also added missing repos
# v2.6 - Added volatility v2.0, DHCP server and changed a few sources for apt
# v2.5 - Added many new fixes by recommendations of Michael Haberland (see below)
#			Fixed pulseaudio so that sound now works by default
#			Installed latest version of ophcrack v3.3.1
#			Added apt alias for apt-get like in Mint
#			Added option to auto login as root
#			Added option to auto startx after root login
#			Improved gnome-network-manager installation
#			Fixed metasploit updater
#			Added UPX-packing and signature stealing to fast-track
# v2.4 - Fixed framework3 to now be framework and turned nmap fingers to default to off
# v2.3 - Fixed an issue with Google PGP key import & SQLMap installation
# v2.2 - Plenty of spelling mistakes now fixed. Cheers Rich Hicks
# v2.1 - Added version 7.0 of hydra (and xhydra)
# v2.0 - Added meld program (quick visual diff between 2/3 files)
# v1.9 - Added tree command
# v1.8 - Added cisco-decrypt tool for pcf encrypred passwords (cisco client vpn)
#      - Added arduino, teensy and teensyduino
#      - Added missing tiger, creepy and arduino to install options
# v1.7 - Added tsclient, moved dropbox location and changed default option to No
# v1.6.1 - Fixed slight mistake in latest addition, Whoops!
# v1.6 - Added tiger, creepy, netwox and arduino. Added sshkey and wicd configuration
# v1.5 - Added deluge bittorent client and jockey-gtk for driver installations
# v1.4 - Ion recommended adding the following:
#			removal of istall icon
#			changing of password
#			addition of mono, recordmydesktop and terminator
#			ability to install dropbox
#			removal of i_set option
#			added apt-get autoremove to end of sections to clean up
# v1.3 - Added clear after diaog and changes openvas setup message
# v1.2 - Added mz, scapy, FernWifiCracker
# v1.1 - Added -u flag to allow skipping to updates function
# v1.0 - Official Release
# v0.4 - Cleaned up and added TUI checklist
# v0.3 - Added nipper, fwbuilder and routerdefense
# v0.2 - Clean with more missing apps
# v0.1 - First release
#
# ToDo:
# - Check if root password is toor (and if it is offer to change it)
# - Remove duplicate WBarConf from the Applications-->Accessories menu
welcome_msg() { #Introduction messagebox
	dialog --title "bt5-fixit.sh" \
	--msgbox "Authors: phillips321 (matt@phillips321.co.uk)
License: CC BY-SA 3.0
Use: Brings tools on BackTrack5 to bleeding edge and adds missing tools
Released: www.phillips321.co.uk
Version: ${version}" 10 60
}
rootcheck() { #checks to see if user is root
	if [ `echo -n $USER` != "root" ]
	then
		dialog --title "EPIC FAIL" --msgbox "You can only run this tool as root" 8 60
		clear
		exit 1
	fi
}
netcheck() { #checks the internet is working
	if [ `ping -c 1 -s 1000 google.com |grep received | awk -F, '{print $2}' |awk '{print $1}' ` -eq 1 ]
	then
		echo "Net connection working"
	else
		dialog --title "EPIC FAIL" --msgbox "You need a net connection to continue..." 8 60
		clear
		echo "You need a net connection to continue..."
		exit 1
	fi	;}
extra_repositories() { #this adds extra repos allowing more software to be installed
		cd /tmp
	grep fwbuilder /etc/apt/sources.list ; addrepos=$?
	if [ ${addrepos} = "1" ] #check to see if repos have already been added
	then
		dialog --title "Extra Repositories"  --yesno "We are now going to install extra repositories and update from them in order for this tool to function. Do you want to continue?" 8 60
		return=$?
		clear
		if [ ${return} == 1 ]
		then
			dialog --title "EPIC FAIL" --msgbox "If you're worried about adding extra repo's please check the code to see which ones are added, the function is called extra_repositories funnily enough..." 8 60
			clear
			echo "If you're worried about adding extra repo's please check the code to see which ones are added, the function is called extra_repositories funnily enough"
			exit 1
		fi
		apt-get install -y python-software-properties
	    	apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 4E5E17B5
		add-apt-repository ppa:chromium-daily/stable
		wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -	
		echo "deb http://packages.fwbuilder.org/deb/stable/ lucid contrib" >> /etc/apt/sources.list
		wget http://www.fwbuilder.org/PACKAGE-GPG-KEY-fwbuilder.asc && apt-key add PACKAGE-GPG-KEY-fwbuilder.asc
		rm PACKAGE-GPG-KEY-fwbuilder.asc
		echo "deb http://dl.google.com/linux/chrome/deb/ stable main #Google Stable Source" >> /etc/apt/sources.list
		wget -O - http://deb.opera.com/archive.key | apt-key add -
		echo "deb http://deb.opera.com/opera/ lenny non-free #Opera Official Source" >> /etc/apt/sources.list
		echo "deb http://archive.getdeb.net/ubuntu lucid-getdeb apps #GetDeb Software Portal" >> /etc/apt/sources.list.d/getdeb.list
		wget -q -O- http://archive.getdeb.net/getdeb-archive.key | apt-key add -
		add-apt-repository ppa:shutter/ppa
		add-apt-repository ppa:tualatrix/ppa
		add-apt-repository ppa:ubuntu-wine/ppa
    		add-apt-repository ppa:deluge-team/ppa
    		add-apt-repository ppa:gnome-terminator/ppa
    		add-apt-repository ppa:mozillateam/firefox-stable
    		add-apt-repository ppa:nilarimogard/webupd8
		echo "deb http://download.virtualbox.org/virtualbox/debian lucid contrib non-free" >> /etc/apt/sources.list
		wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | apt-key add -		
		apt-get update
		apt-get -y dist-upgrade
		apt-get -y autoclean
		dialog --title "bt5-fixit.sh" --msgbox "Repositories have been added and standard updates applied, moving on" 10 60
	else
		dialog --title "bt5-fixit.sh" --msgbox "Repositories already added, moving on" 10 60
	fi
}
configuration_stuff(){ #changes small things that have been overlooked in BackTrack
	dialog --title "Configuration Changes Selection" --separate-output --output-fd 2 --checklist "What minor changes do you wish to make?" 0 0 0 \
		fixsplash "fix the broken splash after an install" on \
		bashcompletion "allow bash completion" on \
		kernelsources "Install kernel sources" on \
		RemoveInstallIcon "Removes install backtrack icon from desktop" on \
		password "change the default root password for the system" on \
		mysql-password "change the default MySQL password" on \
		missing-drivers "allows easy install of nVidia, AMD and Wireless Drivers" on \
		ssh-keys "creates ssh keys for ssh server" on \
		wicd "configure usage of wicd (fix warning message)" off \
		fixsound "make sure pulseaudio starts with gnome" on \
		aptalias "create alias for APT (Like Linux Mint)" on \
		autologin "auto login as root" off \
		autostartx "auto startx after login" off \
		gnomenetworkmanager "gnome network manager in taskbar(top right)" off \
		2> /tmp/answer
	result=`cat /tmp/answer` && rm /tmp/answer ; clear
	for opt in ${result}
	do
		clear
		makeline
		echo "Now running ${opt} "
		makeline
		sleep 2
		case ${opt} in
			fixsplash) : do ; fix-splash ;;
			bashcompletion) : do ; sed -i '/# enable bash completion in/,+3{/enable bash completion/!s/^#//}' /etc/bash.bashrc ; echo "Bash Completion enabled" ;;
			kernelsources) : do ; prepare-kernel-sources ; cd /usr/src/linux ; cp -rf include/generated/* include/linux/ ;;
			RemoveInstallIcon) : do ; if [ -f /root/Desktop/backtrack-install.desktop ]; then rm /root/Desktop/backtrack-install.desktop ; fi ;;
			password) : do ; echo "Time to change the root password" ; passwd ;;
			mysql-password) : do ; echo "Time to change your MySQL password" ; read -s -p "Enter password: " mysqlpass; echo ; service mysql start ; mysqladmin -u root -ptoor password $mysqlpass ; service mysql stop ;;
			missing-drivers) : do ; apt-get -y install jockey-gtk ;;
			ssh-keys) : do ; sshd-generate ;;
			wicd) : do ; dpkg-reconfigure wicd ; update-rc.d wicd defaults ;;
			fixsound) : do ; cd /root/.config/ ; mkdir autostart ; cd autostart ; touch pulseaudio.desktop ; echo -e "\n[Desktop Entry]\nType=Application\nExec=/usr/bin/pulseaudio\nHidden=false\nNoDisplay=false\nX-GNOME-Autostart-enabled=true\nName[en_US]=PulseAudio Sound System\nName=PulseAudio Sound System\nComment[en_US]=Start the PulseAudio Sound System\nComment=Start the PulseAudio Sound System" > pulseaudio.desktop ;;
			aptalias) : do ; touch /root/.bash_aliases ; echo alias apt='apt-get' > /root/.bash_aliases ;;
			autologin) : do ; apt-get -y install rungetty ; sed -i 's/exec /#exec /' /etc/init/tty1.conf ; echo exec /sbin/rungetty tty1 --autologin root >> /etc/init/tty1.conf ;;
			autostartx) : do ; touch /root/.bash_profile ; echo startx > /root/.bash_profile ;;
			gnomenetworkmanager) : do ; i_gnomenetworkmanager ;;
		esac
		sleep 2
	done
}
missing_stuff(){ #installs software that is missing that many people rely on!
	dialog --separate-output --output-fd 2 --title "Missing Tools" --checklist "What do you want to add to BackTrack? (This is missing stuff that for some reason they didn't include!)" 0 0 0 \
		build-essential "contains the tools required for building software" on \
		linux-headers "includes the header files for the kernel" on \
		linux-source "includes the source files for the kernel" on \
		filezilla "an FTP client" on \
		synaptic "gui for aptitude" on \
		geany "Text editor for programmers" on \
		eric "full featured Python IDE" off \
		rapidsvn "GUI client for subversion" off \
		netsed "changes network packets off the fly" on \
		arp-scan "allows enumeration of devices off subnet" on \
		shutter "great screenshot utility for gnome" on \
		gnome-web-photo "allows screenshots to be taken of URLs" on \
		vino "Gnome VNC server" off \
		etherape "grpahical network monitor" on \
		gufw "gnome frontend for UbuntuFireWall" on \
		htop "like top but more functions" on \
		libssl-dev "SSL development libraries" on \
		scapy "packet manipulation program" on \
		nessus "vulnerability assessment tool" on \
		python-dev "python development libraries" on \
		default-jdk "Java Development Kit" on \
		chromium-codecs-ffmpeg-extra "chromium extras" on \
		chromium-codecs-ffmpeg-nonfree "chromium extras" on \
		opera "another web browser, the more the merrier" off \
		flashplugin-nonfree-extrasound "adobe flash plugin extras" on \
		flashplugin-nonfree "adobe flash plugin " on \
		p7zip-full "7zip archive utility" on \
		p7zip-rar "7zip archive rar capabilities" on \
		file-roller "gnome based archive mounter" on \
		giplet "Gnome applet to display IP (Rightclick toolbar-> add to panel)" on \
		ubuntu-tweak "configure gnome (max,min,close button location)" on \
		python-vte "python terminal emulator libraries" on \
		compiz-plugins "compiz plugins for the matrix effect" on \
		screen "allows multiple terminals in one session" on \
		fwbuilder "allows creation/import of firewall rulesets" on \
		mz "allows creation of packets" on \
		scapy "allows creation of packets" on \
		gcalctool "default gnome calculator" on \
		gtk-recordmydesktop "allows you to easily record your entire screen" on \
		mono-runtime "mono runtime tools" on \
		mono-devel "mono development libraries" off \
		openoffice.org "office productivity suite" off \
		webhttrack "offline browsing utility" on \
		terminator "terminal emulator with advanced features" on \
		deluge "bittorent client" on \
		netwox "network toolbox" on \
		tsclient "Terminal Servers Client" on \
		putty "Telnet/SSH client for X" on \
		tree "Linux tree command" on \
		meld "Quick way to show a visual diff between 2/3 files" on \
		tiger "Unix server security checker" off \
		dhcp3-server "Add a DHCP server to BT5" off \
    		launchpad-getkeys "Manage missing keys for repositories" on \
    		unetbootin "Allows creation of bootable USB drives from ISOs" on \
    		parcellite "Management of the clipboard" on \
    		tsocks "allows connection from terminal to HTTPS" on \
		2> /tmp/answer
	result=`cat /tmp/answer` && rm /tmp/answer ; clear
	apt-get install -y ${result}
	apt-get -y clean
	apt-get -y autoremove
	}
install_stuff(){ #removes existing packages and replaces them with svn versions
	dialog --title "Install from SVN"  --yesno "We are now going to install packages from svn source. This will allow updating to the latest versions. Do you want to continue?" 8 60
	return=$?
	if [ ${return} == 0 ]
	then
		dialog --separate-output --output-fd 2 --title "Convert to SVN" --checklist "What packages do you want to install/convert to SVN installs?" 0 0 0 \
		wifite "mass wep/wpa cracker" on \
		openvas "Open Vulnerability Assessment System" on \
		routerdefense "Cisco auditer" on \
		fernwificracker "GUI based wifi cracker" on \
		dropbox "Install Dropbox" off \
		skype "VoIP communication software" on \
		arduino "Arduino based tools (includes teensy addons)" off \
		cisco-decrypt "Allows decode of pcf password hashes" on \
		ophcrack "Windows password cracker based on rainbow tables" on \
		msfupdater "fixes metasploit updater" on \
		volatility "installs version 2.0 of volatility" on \
		adobereader "install Adobe Reader" on \
		hostmap "hostname and virtual host enumeration" on \
		absinthe "GUI tool to automate blind sql injection" on \
		virtualbox "create and manage virtual machines"	on \
		2> /tmp/answer
		result=`cat /tmp/answer` && rm /tmp/answer ; clear
		for opt in ${result}
		do
			clear
			makeline
			echo "Now installing: ${opt}"
			makeline
			sleep 2
			case ${opt} in
				wifite) : do ; i_wifite ;;
				openvas) : do ; i_openvas ;;
				routerdefense) : do ; i_routerdefense ;;
				fernwificracker) : do ; i_fernwificracker ;;
				dropbox) : do ; i_dropbox ;;
				skype) : do ; i_skype ;;
				arduino) : do ; i_arduino ;;
				cisco-decrypt) : do ; i_cisco-decrypt ;;
				ophcrack) : do ; i_ophcrack ;;
				msfupdater) : do ; i_msfupdater ;;
				volatility) : do ; i_volatility ;; 
				adobereader) : do ; i_adobereader ;; 
				hostmap) : do ; i_hostmap ;; 
				absinthe) : do ; i_absinthe ;;
				virtualbox) : do ; i_virtualbox ;; 
			esac
			sleep 2
		done
	else
		echo "skipped svn install"
	fi
	apt-get -y clean
	apt-get -y autoremove
}
update_stuff(){ #updates packages previously converted to svn
	dialog --separate-output --output-fd 2 --title "Tool Updater" --checklist "What packages do you want to update?" 0 0 0 \
		msf "update me?" on \
		w3af "update me?" on \
		openvas "update me?" on \
		set "update me?" on \
		sqlmap "update me?" on \
		fasttrack "update me?" on \
		nikto "update me?" on \
		exploitdb "update me?" on \
		nessus "update me?" on \
		routerdefense "update me?" on \
		warvox "update me?" on \
		giskismet "update me?" on \
		nmap "update nmap fingerprints?" on \
		fimap "update me?" on \
		wifite "update me?" on \
		fernwificracker "update me?" on \
		2> /tmp/answer
	result=`cat /tmp/answer` && rm /tmp/answer ; clear
	for opt in ${result}
	do
		clear
		makeline
		echo "Now updating: ${opt}"
		makeline
		sleep 2
		case ${opt} in
			wifite) : do ; u_wifite ;;
			msf) : do ; u_msf ;;
			w3af) : do ; u_w3af ;;
			openvas) : do ; u_openvas ;;
			set) : do ;u_set ;;
			fasttrack) : do ;u_fasttrack ;;
			sqlmap) : do ; u_sqlmap ;;
			nikto) : do ; u_nikto ;;
			exploitdb) : do ; u_exploitdb ;;
			nessus) : do ; u_nessus ;;
			routerdefense) : do ; u_routerdefense ;;
			warvox) : do ; u_warvox ;;
			giskismet) : do ; u_giskismet ;;
			nmap) : do ; u_nmap ;;
			fimap) : do ; u_fimap ;;
			fernwificracker) : do ; u_fernwificracker ;;
		esac
		sleep 2
	done
	apt-get -y clean
	apt-get -y autoremove	
}
goodbye_msg() {
	dialog --title "bt5-fixit.sh" --msgbox "Updates Complete!
In the future you can run this command with the -u flag" 10 60
	clear
}
help_msg() { # help message
	clear
	echo -e "Usage: $0 [options]
 Options:
  -u : Update packages (only use me after you have run the script normally)
  -h : This help message!
 Example:
        $0 fiu"
        exit 1
}
### Installers for each program ########################################################################################
i_wifite() {
	cd /pentest/wireless/
	wget -O wifite.py http://wifite.googlecode.com/svn/trunk/wifite.py
	chmod +x wifite.py ; }
i_openvas() {
	apt-get install -y openvas-scanner
	dialog --title "OpenVAS install" \
	--msgbox "You are about to setup OpenVAS. These are the setup instructions, read them!
During install a certificate will be created - Just press [Enter] 7 times
Enter the username - most people use root[Enter]
Tell OpenVas you want to use a password - Just press [Enter]
Enter the password - most people use toor
Enter blank rules if you wish - Ctrl-D when done
Tell OpenVas you're happy with the settings - Just press [Enter]" 20 70
	openvas-mkcert
	openvas-adduser  
	}
i_routerdefense() { svn checkout http://routerdefense.googlecode.com/svn/trunk/ /var/www/routerdefense ;}
i_fernwificracker() {
	cd /pentest/wireless/
	svn checkout http://fern-wifi-cracker.googlecode.com/svn/Fern-Wifi-Cracker/
	chmod +x /pentest/wireless/fern-wifi-cracker/execute.py
	}
i_dropbox(){
	if [ "`dpkg -s nautilus-dropbox | grep Status`" != "Status: install ok installed" ]
	then
		wget -N http://linux.dropbox.com/packages/nautilus-dropbox_0.6.8_i386.deb
		dpkg -i nautilus-dropbox_0.6.8_i386.deb
		nautilus --quit #restart nautilus
		dropbox start -i #run gui installer
		dialog --title "DropBox Setup" --msgbox "Click OK when Dropbox setup is complete" 8 60
		clear
		dropbox autostart y #already by default, just to be sure
		rm nautilus-dropbox_0.6.8_i386.deb
	fi
}
i_skype(){
	cd /tmp/
	wget http://download.skype.com/linux/skype-ubuntu_2.2.0.35-1_i386.deb
	dpkg -i skype-ubuntu_2.2.0.35-1_i386.deb
	rm skype-ubuntu_2.2.0.35-1_i386.deb
}
i_arduino(){
	apt-get -y install avr-libc make ant
	cd /pentest/misc/
	wget http://arduino.googlecode.com/files/arduino-0022.tgz 
	tar -zxvf arduino-0022.tgz
	rm arduino-0022.tgz
	cd /etc/udev/rules.d/
	wget http://www.pjrc.com/teensy/49-teensy.rules
	cd /pentest/misc/arduino-0022/
	wget http://www.pjrc.com/teensy/teensy.gz
	gzip -d teensy.gz 
	chmod +x teensy
	wget http://www.pjrc.com/teensy/teensyduino.32bit
	chmod +x teensyduino.32bit
	dialog --title "Teensyduino Install" \
	--msgbox "You are about to setup teensyduino. Read this before you proceed.
Instructions:
	Click Next
	Change the install folder to /pentest/misc/arduino-0022/
	Click Next
	Select All of the tools
	Click Next and then Install	" 10 70
	/pentest/misc/arduino-0022/teensyduino.32bit
	clear
	rm /pentest/misc/arduino-0022/teensyduino.32bit
	}
i_cisco-decrypt() {
	cd /pentest/passwords/
	wget http://www.unix-ag.uni-kl.de/~massar/soft/cisco-decrypt.c
	gcc -Wall -o cisco-decrypt cisco-decrypt.c $(libgcrypt-config --libs --cflags)
	}
i_gnomenetworkmanager(){
	apt-get -y install network-manager-gnome
	mv /etc/network/interfaces /etc/network/interfaces.ori
	echo "auto lo" > /etc/network/interfaces && echo "iface lo inet loopback" >> /etc/network/interfaces
	service network-manager start
}
i_ophcrack(){
	apt-get -y remove ophcrack
	apt-get -y install libssl-dev libqt4-dev
	cd /pentest/passwords
	wget http://sourceforge.net/projects/ophcrack/files/ophcrack/3.3.1/ophcrack-3.3.1.tar.bz2
	tar -xjf ophcrack-3.3.1.tar.bz2
	rm -rf ophcrack-3.3.1.tar.bz2
	mv ophcrack*/ ophcrack/
	cd ophcrack/
	./configure
	make
	make install
	rm -r /pentest/passwords/ophcrack
}
i_msfupdater(){ #Fix for errors in Metasploit-updater
	cd /opt/framework/lib
	sudo mv libcrypto.so.0.9.8 libcrypto.so.0.9.8.bak
	sudo mv libssl.so.0.9.8 libssl.so.0.9.8.bak
	sudo ln -s /usr/lib/libcrypto.so.0.9.8 ./
	sudo ln -s /usr/lib/libssl.so.0.9.8 ./
}
i_volatility(){
	apt-get -y install cmake
	cd /root/
	wget https://freddie.witherden.org/tools/libforensic1394/releases/libforensic1394-0.2.tar.gz
	tar zxvf libforensic1394-0.2.tar.gz
	cd libforensic1394-0.2/
	cmake -G"Unix Makefiles"
	make
	cp libforensic1394.s* /usr/lib/
	cd python/
	python setup.py install
	rm -rf /pentest/forensics/volatility
	cd /root/
	wget https://www.volatilesystems.com/volatility/2.0/volatility-2.0.tar.gz
	tar zxvf volatility-2.0.tar.gz
	mv /root/volatility-2.0 /pentest/forensics/volatility
	sed -i -e ‘s|\./volatility|\./vol\.py -h|’ /usr/share/applications/backtrack-volatility.desktop
	cd /root/
	rm -rf libforensic1394*
	rm -rf volatility-2.0.tar.gz
}
i_adobereader(){
	cd /tmp
	wget ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.4.7/enu/AdbeRdr9.4.7-1_i386linux_enu.deb
	dpkg -i AdbeRdr9.4.7-1_i386linux_enu.deb
	cd -
}
i_hostmap(){
	cd /pentest/enumeration/web/
	svn co http://svn.lonerunners.net/projects/hostmap/trunk hostmap
	cd hostmap && chmod +x hostmap.rb
}
i_absinthe(){
	apt-get install -y mono-runtime mono-devel
	cd /tmp/
	wget http://www.0x90.org/releases/absinthe/Absinthe-1.4.1-Linux.tar.gz
	tar xvf Absinthe-1.4.1-Linux.tar.gz
	cd Absinthe-1.4.1-Linux/
	./install.sh
}
i_virtualbox(){
	prepare-kernel-sources
	cd /usr/src/linux
	cp -rf include/generated/* include/linux/
	apt-get install dkms
	apt-get install virtualbox-4.1
}
### Update commands for each program ###################################################################################
u_wifite() { /pentest/wireless/wifite.py -upgrade ; }
u_msf() { msfupdate ; }
u_w3af() { svn up /pentest/web/w3af/ ;}
u_openvas() { openvas-nvt-sync ;}
u_set() { cd /pentest/exploits/set/ ; ./set-update ;}
u_fasttrack() { svn up /pentest/exploits/fasttrack/ ;}
u_sqlmap() { cd /pentest/database/sqlmap/ ; python sqlmap.py --update ; } 
u_nikto() { cd /pentest/web/nikto/ ; svn up ; ./nikto.pl -update ;}
u_exploitdb() { svn up /pentest/exploits/exploitdb ;}
u_nessus() { 
	ps -A | grep nessus > /dev/null
	if [ $? != 0 ]; then
    		/etc/init.d/nessusd start
			sleep 10
	fi
	/opt/nessus/sbin/nessus-update-plugins ;}
u_routerdefense() { svn up /var/www/routerdefense/ ;}
u_warvox() { rm -rf /pentest/telephony/warvox/ ; svn co http://www.metasploit.com/svn/warvox/trunk /pentest/telephony/warvox;}
u_giskismet() { svn up /pentest/wireless/giskismet/ ;}
u_nmap() { nmap --script-updatedb ;}
u_fimap() { cd /pentest/web/fimap/ && ./fimap.py --update-def ;}
u_fernwificracker() { svn up /pentest/wireless/fern-wifi-cracker/ ; chmod +x /pentest/wireless/fern-wifi-cracker/execute.py ;}
makeline(){ printf "%${1:-$COLUMNS}s\n" ""|tr " " ${2:-#;};}
main(){ #default block of code
startdir=`pwd` ; cd /tmp/
if [ "$#" == 0 ]
then # default run to include everything
	welcome_msg; rootcheck; netcheck; extra_repositories; configuration_stuff; missing_stuff; install_stuff; update_stuff; goodbye_msg
else # only run me if i recieve a command line value
	while getopts "uh" execute; do
		case ${execute} in
			u) welcome_msg; rootcheck; netcheck; update_stuff; goodbye_msg ;;
			h) help_msg ;;
			?) help_msg ;;
		esac
	done
fi
cd ${startdir}
}
main $*
exit 0
