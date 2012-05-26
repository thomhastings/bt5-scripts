#!/bin/sh
echo -e "\e[31mBack|Track 5r2\e[0m Post-Install Script"
echo -e "\e[37m(c) Thom Hastings 2012 New BSD license\e[0m"
echo
echo -e "Getting \e[33mWifite\e[0m..."
./get-wifite.sh
echo
echo -e "Getting \e[33mTor\e[0m..."
./get-tor.sh
echo
echo -e "Getting \e[33mFiglet\e[0m..."
./get-figlet.sh
echo
echo -e "Getting \e[33mwordlists\e[0m..."
./get-wordlists.sh
echo
echo -e "Getting \e[33mscripts\e[0m..."
./get-scripts.sh
echo
echo -e "Installing \e[33mYakuake\e[0m..."
apt-get install yakuake -y
echo
echo -e "Downloading & installing \e[36mDropbox\e[0m..."
cd ~
echo "Checking prerequisites..."
apt-get install python-gpgme
echo "Downloading..."
wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.4.0_i386.deb
echo "Installing..."
dpkg -i download\?dl\=packages%2Fubuntu%2Fdropbox_1.4.0_i386.deb
echo "Cleaning up..."
rm download\?dl\=packages%2Fubuntu%2Fdropbox_1.4.0_i386.deb
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
echo "Getting a GRUB theme..."
cd ~
wget http://dl.dropbox.com/u/80562560/grub%20matrix%20theme/grub2-matrix-theme.tar.gz
tar xvf grub2-matrix-theme.tar.gz
cd matrix
echo "Installing..."
./install.sh
echo "Cleaning up..."
cd ..
rm -rf matrix/
rm grub2-matrix-theme.tar.gz
echo
echo "Getting a bootsplash theme..."
cd /opt/bootsplash/
mkdir themes
cd themes
echo "Downloading theme..."
wget http://matrixsplash.altervista.org/matrix-splash-v1.0.tar.gz
echo "Decompressing theme..."
tar xvf matrix-splash-v1.0.tar.gz
cd ..
echo "Downloading bootsplash..."
wget ftp://ftp.bootsplash.org/pub/bootsplash/rpm-sources/bootsplash/bootsplash-3.1.tar.bz2
tar xvf bootsplash-3.1.tar.bz2
cd bootsplash-3.1
cd Utilities
echo "Compiling bootsplash..."
make
echo "Writing config file.."
echo "# config file version" >> matrix-bootsplash-1024x768.cfg
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
echo "Applying new splash..."
./splash -s -f matrix-bootsplash-1024x768.cfg > /opt/bootsplash/bootsplash.matrix
cp /opt/bootsplash/bootsplash /opt/bootsplash/bootsplash.old-bt5
cp /opt/bootsplash/bootsplash.matrix /opt/bootsplash/bootsplash
echo "Running fix-splash..."
fix-splash
cd ..
cd ..
echo "Cleaning up..."
rm -rf bootsplash-3.1
rm bootsplash-3.1.tar.bz2
cd ~
echo
echo "Getting Audacious..."
./get-audacious.sh
echo
echo "Updating \e[31mBack|Track\e[0m..."
cd /pentest/scripts
python bt5up.py
echo
echo -e "\e[32mDONE\e[0m"
