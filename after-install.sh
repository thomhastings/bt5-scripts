#!/bin/sh
echo -e "\e[31mBack|Track 5r3\e[0m Post-Install Script"
echo -e "\e[37m(c) Thom Hastings 2012 New BSD license\e[0m"
echo
echo -e "Getting \e[33mTor\e[0m..."
sh get-tor.sh
echo
echo -e "Getting \e[33mFiglet\e[0m..."
sh get-figlet.sh
echo
echo -e "Getting \e[33mwordlists\e[0m..."
sh get-wordlists.sh
echo
echo -e "Getting \e[33mscripts\e[0m..."
sh get-scripts.sh
echo
echo -e "Installing \e[33mGuake\e[0m & \e[33mTilda\e[0m..."
apt-get install guake tilda -y
echo
echo -e "Downloading & installing \e[36mDropbox\e[0m..."
echo "Getting prerequisites..."
apt-get install python-gpgme -y
cd ~
MACHINE_TYPE=`uname -m`
echo "Machine type is $MACHINE_TYPE"
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  echo "Downloading 64-bit..."
  wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
else
  echo "Downloading 32-bit..."
  wget -O - "https://www.dropbox.com/download?plat=lnx.x86" | tar xzf -
fi
echo "Installing..."
echo -e "Starting Dropbox installer-- \e[33mfollow instructions\e[0m!"
start ~/.dropbox-dist/dropboxd
echo
echo "Getting Google Chrome..."
echo "deb http://dl.google.com/linux/deb/ stable non-free main" >> /etc/apt/sources.list
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
apt-get update
apt-get install google-chrome-stable -y
sed -i 's/exec.*/& --user-data-dir/g' /usr/bin/google-chrome
echo
echo "Grabbing a few wallpapers..."
cd /usr/share/wallpapers/backtrack/
wget http://www.n1tr0g3n.com/wp-content/uploads/2011/12/Fucking-ninja-is-Bad-ass.jpg
wget http://www.n1tr0g3n.com/wp-content/uploads/2011/12/matrix_hacker_by_zahid4world-d3dyf5r2.jpg
wget http://www.n1tr0g3n.com/wp-content/uploads/2011/12/miscellaneous-95767.jpeg
wget http://www.n1tr0g3n.com/wp-content/uploads/2011/12/wallpaper-1000423.png
wget http://pip.cat/bloc/wp-content/uploads/2012/05/hacker_manifesto_mentor.jpg
wget http://www.wallpaper4me.com/images/wallpapers/sexyteacher-376799.jpeg
echo
echo "Customizing GRUB and BootSplash..."
#--- GRUB theme
cd /usr/local/src/
wget http://dl.dropbox.com/u/80562560/grub%20matrix%20theme/grub2-matrix-theme.tar.gz
tar xvf grub2-matrix-theme.tar.gz
cd matrix/
bash install.sh #y
rm -rf /usr/local/src/{matrix/,grub2-matrix-theme.tar.gz}
update-grub
#--- bootsplash theme
cd /usr/local/src/
if [ ! -e /usr/local/src/bootsplash-3.1.tar.bz2 ]; then wget ftp://ftp.bootsplash.org/pub/bootsplash/rpm-sources/bootsplash/bootsplash-3.1.tar.bz2; fi
tar xvjf bootsplash-3.1.tar.bz2
cd bootsplash-*/Utilities/
make splash
mkdir -p /opt/bootsplash/themes/
cd /opt/bootsplash/themes/
wget http://matrixsplash.altervista.org/matrix-splash-v1.0.tar.gz
tar xvf matrix-splash-v1.0.tar.gz
rm matrix-splash-v1.0.tar.gz
echo "# config file version" > matrix-bootsplash-1024x768.cfg
echo "version=3" >> matrix-bootsplash-1024x768.cfg
echo >> matrix-bootsplash-1024x768.cfg
echo "# should the picture be displayed?" >> matrix-bootsplash-1024x768.cfg
echo "state=1" >> matrix-bootsplash-1024x768.cfg
echo >> matrix-bootsplash-1024x768.cfg
echo "# fgcolor is the text forground color." >> matrix-bootsplash-1024x768.cfg
echo "# bgcolor is the text background (i.e. transparent) color." >> matrix-bootsplash-1024x768.cfg
echo "fgcolor=7" >> matrix-bootsplash-1024x768.cfg
echo "bgcolor=0" >> matrix-bootsplash-1024x768.cfg
echo >> matrix-bootsplash-1024x768.cfg
echo "# (tx, ty) are the (x, y) coordinates of the text window in pixels." >> matrix-bootsplash-1024x768.cfg
echo "# tw/th is the width/height of the text window in pixels." >> matrix-bootsplash-1024x768.cfg
echo "tx=80" >> matrix-bootsplash-1024x768.cfg
echo "ty=140" >> matrix-bootsplash-1024x768.cfg
echo "tw=865" >> matrix-bootsplash-1024x768.cfg
echo "th=560" >> matrix-bootsplash-1024x768.cfg
echo >> matrix-bootsplash-1024x768.cfg
echo "# name of the picture file (full path recommended)" >> matrix-bootsplash-1024x768.cfg
echo "jpeg=/opt/bootsplash/themes/matrix-splash/images/bootsplash-1024x768.jpg" >> matrix-bootsplash-1024x768.cfg
echo "silentjpeg=/opt/bootsplash/themes/matrix-splash/images/silent-1024x768.jpg" >> matrix-bootsplash-1024x768.cfg
echo "progress_enable=1" >> matrix-bootsplash-1024x768.cfg
echo "overpaintok=1" >> matrix-bootsplash-1024x768.cfg
cp -n /opt/bootsplash/bootsplash{,.bkup}
/usr/local/src/bootsplash-*/Utilities/splash -s -f matrix-bootsplash-1024x768.cfg > /opt/bootsplash/bootsplash
cd ~
echo
echo "Getting \e[32Audacious\e[0m..."
sh get-audacious.sh
echo
echo "Cleaning up..."
apt-get autoremove -y
echo
echo "Fixing splash..."
fix-splash
echo
echo "Updating \e[31mBack|Track\e[0m..."
cd /pentest/scripts
python bt5up.py
echo
echo -e "\e[32mDONE\e[0m"
