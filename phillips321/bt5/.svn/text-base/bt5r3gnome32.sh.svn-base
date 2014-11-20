###fresh install of bt5r3
## add sources
apt-get install -y python-software-properties
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 4E5E17B5
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 9BDB3D89CE49EC21

echo "deb http://packages.fwbuilder.org/deb/stable/ lucid contrib" >> /etc/apt/sources.list
echo "deb http://dl.google.com/linux/chrome/deb/ stable main #Google Stable Source" >> /etc/apt/sources.list
echo "deb http://deb.opera.com/opera/ lenny non-free #Opera Official Source" >> /etc/apt/sources.list
echo "deb http://archive.getdeb.net/ubuntu lucid-getdeb apps #GetDeb Software Portal" >> /etc/apt/sources.list.d/getdeb.list

add-apt-repository ppa:chromium-daily/stable
add-apt-repository ppa:shutter/ppa
add-apt-repository ppa:tualatrix/ppa
add-apt-repository ppa:ubuntu-wine/ppa
add-apt-repository ppa:deluge-team/ppa
add-apt-repository ppa:gnome-terminator/ppa
add-apt-repository ppa:mozillateam/firefox-stable
add-apt-repository ppa:nilarimogard/webupd8

wget -q -O - http://deb.opera.com/archive.key | apt-key add -
wget -q -O - http://archive.getdeb.net/getdeb-archive.key | apt-key add -
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
wget -q -O - http://www.fwbuilder.org/PACKAGE-GPG-KEY-fwbuilder.asc | apt-key add -

## updates
apt-get update
apt-get -y dist-upgrade

##installs
apt-get -y install jockey-gtk rungetty linux-headers filezilla synaptic geany shutter gnome-web-photo vino gufw nessus python-dev chromium-codecs-ffmpeg-extra chromium-codecs-ffmpeg-nonfree opera flashplugin-nonfree-extrasound flashplugin-nonfree file-roller giplet compiz-plugins fwbuilder gcalctool gtk-recordmydesktop mono-runtime mono-devel deluge tsclient meld launchpad-getkeys unetbootin wine1.3-gecko cmake tftp ntp rcconf rsh-client arp-scan dialog tree sslscan
apt-get -y clean
apt-get -y autoremove
apt-get -y autoclean		


#config bits
#bash completetion
sed -i '/# enable bash completion in/,+3{/enable bash completion/!s/^#//}' /etc/bash.bashrc
#kernel sources
prepare-kernel-sources ; cd /usr/src/linux ; cp -rf include/generated/* include/linux/
#ssh keys
sshd-generate
#fix sounds
cd /root/.config/ ; mkdir autostart ; cd autostart ; touch pulseaudio.desktop ; echo -e "\n[Desktop Entry]\nType=Application\nExec=/usr/bin/pulseaudio\nHidden=false\nNoDisplay=false\nX-GNOME-Autostart-enabled=true\nName[en_US]=PulseAudio Sound System\nName=PulseAudio Sound System\nComment[en_US]=Start the PulseAudio Sound System\nComment=Start the PulseAudio Sound System" > pulseaudio.desktop

#nessus add user
nessus-adduser
dialog --msgbox "make sure to run nessus-fetch --register YOURKEYHERE" 20 70
#openvas certs and user
openvas-mkcert ; openvas-adduser ; openvas-nvt-sync
#fix clock
dpkg-reconfigure tzdata
#fix keyboard
dpkg-reconfigure console-setup
#fix broken warvox
rm -rf /pentest/telephony/warvox/ ; svn co http://www.metasploit.com/svn/warvox/trunk /pentest/telephony/warvox
#run beef_install.sh script
beef_install.sh

##manual installs
#install cisco-decrypt
cd /pentest/passwords/ ; wget http://www.unix-ag.uni-kl.de/~massar/soft/cisco-decrypt.c ; gcc -Wall -o cisco-decrypt cisco-decrypt.c $(libgcrypt-config --libs --cflags) ; rm cisco-decrypt.c
#install adobe reader
cd /tmp ; wget ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.5.1/enu/AdbeRdr9.5.1-1_i386linux_enu.deb ; dpkg -i AdbeRdr9.5.1-1_i386linux_enu.deb

#manual things to do!
#change font size to 9
#add unlimited scroll back in gnome-terminal
#add giplet and system monitor to task bar

##my tools
svn checkout http://phillips321.googlecode.com/svn/trunk/ /root/phillips321
echo 'export PATH=$PATH:/root/phillips321' >> /root/.bashrc


##things to update each sunday
/pentest/wireless/wifite/wifite.py -upgrade
msfupdate
svn up /pentest/web/w3af/
openvas-nvt-sync
cd /pentest/exploits/set/ ; ./set-update
svn up /pentest/exploits/fasttrack/
cd /pentest/database/sqlmap/ ; ./sqlmap.py --update
cd /pentest/web/nikto/ ; svn up ; ./nikto.pl -update
svn up /pentest/exploits/exploitdb
ps -A | grep nessus > /dev/null
/etc/init.d/nessusd start ; sleep 10 ; nessus-update-plugins
svn up /pentest/telephony/warvox
svn up /pentest/wireless/giskismet/
nmap --script-updatedb
cd /pentest/web/fimap/ ; ./fimap.py --update-def ; rm /root/fimap.log
svn up /pentest/wireless/fern-wifi-cracker
svn up /root/phillips321







