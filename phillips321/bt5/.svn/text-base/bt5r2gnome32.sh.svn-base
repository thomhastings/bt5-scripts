###fresh install of bt5r2
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

wget -O - http://deb.opera.com/archive.key | apt-key add -
wget -q -O- http://archive.getdeb.net/getdeb-archive.key | apt-key add -
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
wget -q -O - http://www.fwbuilder.org/PACKAGE-GPG-KEY-fwbuilder.asc | apt-key add -

## updates
apt-get update
apt-get -y dist-upgrade

##installs
apt-get -y install jockey-gtk rungetty linux-headers filezilla synaptic geany shutter gnome-web-photo vino gufw nessus python-dev chromium-codecs-ffmpeg-extra chromium-codecs-ffmpeg-nonfree opera flashplugin-nonfree-extrasound flashplugin-nonfree file-roller giplet ubuntu-tweak compiz-plugins fwbuilder gcalctool gtk-recordmydesktop mono-runtime mono-devel deluge tsclient meld launchpad-getkeys unetbootin wine1.3-gecko cmake tftp ntp rcconf rsh-client rlogin
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
#auto login
sed -i 's/exec /#exec /' /etc/init/tty1.conf ; echo exec /sbin/rungetty tty1 --autologin root >> /etc/init/tty1.conf
#fix mfsupdate that moans about libssl and libcrypto
cd/opt/metasploit/common/lib
mv libcrypto.so.0.9.8 libcrypto.so.0.9.8.bak
mv libssl.so.0.9.8 libssl.so.0.9.8.bak
ln -s /usr/lib/libcrypto.so.0.9.8 ./
ln -s /usr/lib/libssl.so.0.9.8 ./
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
#wifite
cd /pentest/wireless/ ; wget -O wifite.py http://wifite.googlecode.com/svn/trunk/wifite.py ;chmod +x wifite.py ; ./wifite.py -upgrade
#ferm-wifi-cracker
cd /pentest/wireless/ ; svn co http://fern-wifi-cracker.googlecode.com/svn/Fern-Wifi-Cracker/ ; chmod +x Fern-Wifi-Cracker/execute.py
#install cisco-decrypt
cd /pentest/passwords/ ; wget http://www.unix-ag.uni-kl.de/~massar/soft/cisco-decrypt.c ; gcc -Wall -o cisco-decrypt cisco-decrypt.c $(libgcrypt-config --libs --cflags)
#install adobe reader
cd /tmp ; wget ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.4.7/enu/AdbeRdr9.4.7-1_i386linux_enu.deb ; dpkg -i AdbeRdr9.4.7-1_i386linux_enu.deb
#install java
killall -9 /opt/firefox/firefox-bin
wget http://javadl.sun.com/webapps/download/AutoDL?BundleId=52240 -O /tmp/java.bin
mkdir -p /opt/java && cd /opt/java
chmod +x /tmp/java.bin && /tmp/java.bin
update-alternatives --install /usr/bin/java java /opt/java/jre1.6.?_??/bin/java 1
update-alternatives --set java /opt/java/jre1.6.?_??/bin/java
Adding the plugin to Firefox.
mkdir -p /usr/lib/mozilla/plugins/
ln -sf /opt/java/jre1.6.?_??/lib/i386/libnpjp2.so /usr/lib/mozilla/plugins/
export JAVA_HOME=”/opt/java/jre1.6.?_??/bin/java”
#manual bits
#change font size to 8
#add giplet and system monitor to task bar

##my tools
svn checkout http://phillips321.googlecode.com/svn/trunk/ /root/phillips321


##things to update each sunday
/pentest/wireless/wifite.py -upgrade
msfupdate
svn up /pentest/web/w3af/
openvas-nvt-sync
cd /pentest/exploits/set/ ; ./set-update
svn up /pentest/exploits/fasttrack/
cd /pentest/database/sqlmap/ ; python sqlmap.py --update
cd /pentest/web/nikto/ ; svn up ; ./nikto.pl -update
svn up /pentest/exploits/exploitdb
ps -A | grep nessus > /dev/null
/etc/init.d/nessusd start ; sleep 10 ; nessus-update-plugins
svn up /pentest/telephony/warvox
svn up /pentest/wireless/giskismet/
nmap --script-updatedb
cd /pentest/web/fimap/ && ./fimap.py --update-def
svn up /pentest/wireless/Fern-Wifi-Cracker/ ; chmod +x /pentest/wireless/Fern-Wifi-Cracker/execute.py
svn up /root/phillips321






