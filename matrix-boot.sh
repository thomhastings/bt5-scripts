#!/bin/sh
echo "Set Matrix Boot (Splash & GRUB) script"
echo "(c) Thom Hastings 2013 New BSD license"
echo
echo -e "Installing \e[32mcmatrix\e[0m just for fun"
apt-get install cmatrix -y
echo
echo -e "Customizing \e[33mGRUB\e[0m and \e[33mBootSplash\e[0m..."
#--- GRUB theme
cd /usr/local/src/
echo -e "Downloading \e[33mGRUB\e[0m theme..."
wget http://dl.dropbox.com/u/80562560/grub%20matrix%20theme/grub2-matrix-theme.tar.gz
echo "Decompressing..."
tar xvf grub2-matrix-theme.tar.gz
cd matrix/
echo -e "Installing... \e[33mtype 'y'\e[0m"
sh install.sh
echo "Cleaning up..."
rm -rf /usr/local/src/{matrix/,grub2-matrix-theme.tar.gz}
echo "Running update-grub..."
update-grub
echo
#--- bootsplash theme
echo -e "Customizing \e[33mBootSplash\e[0m theme:"
cd /usr/local/src/
echo -e "Downloading \e[33mBootSplash\e[0m..."
if [ ! -e /usr/local/src/bootsplash-3.1.tar.bz2 ]; then wget ftp://ftp.bootsplash.org/pub/bootsplash/rpm-sources/bootsplash/bootsplash-3.1.tar.bz2; fi
echo "Decompressing..."
tar xvjf bootsplash-3.1.tar.bz2
cd bootsplash-*/Utilities/
echo "Compiling..."
make splash
echo "Downloading theme..."
mkdir -p /opt/bootsplash/themes/
cd /opt/bootsplash/themes/
wget http://matrixsplash.altervista.org/matrix-splash-v1.0.tar.gz
echo "Decompressing..."
tar xvf matrix-splash-v1.0.tar.gz
rm matrix-splash-v1.0.tar.gz
echo "Writing config file..."
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
echo "Installing..."
/usr/local/src/bootsplash-*/Utilities/splash -s -f matrix-bootsplash-1024x768.cfg > /opt/bootsplash/bootsplash
echo "Running fix-splash..."
fix-splash
echo
echo -e "\e[32mDONE\e[0m"
