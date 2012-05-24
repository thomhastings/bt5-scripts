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
echo -e "Downloading & installing \e[36mDropbox\e[0m..."
cd ~
wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.4.0_i386.deb
dpkg -i download\?dl\=packages%2Fubuntu%2Fdropbox_1.4.0_i386.deb
rm download\?dl\=packages%2Fubuntu%2Fdropbox_1.4.0_i386.deb
echo
echo "Updating \e[31mBack|Track\e[0m..."
cd /pentest/scripts
python bt5up.py
echo
echo -e "\e[32mDONE\e[0m"
