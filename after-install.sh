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
echo "Updating \e[31mBack|Track\e[0m..."
cd /pentest/scripts
python bt5up.py
echo
echo -e "\e[32mDONE\e[0m"
