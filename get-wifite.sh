#/bin/sh
echo "Get Wifite & dependencies script"
echo -e "\e[37m(c) Thom Hastings 2011 BSD-license\e[0m"
echo -e "designed for \e[31mBack|Track 5r1\e[0m"
echo
echo "Downloading Wifite..."
cd /pentest/wireless
svn checkout http://wifite.googlecode.com/svn/trunk wifite
cd ~
echo
echo "Updating packages..."
sudo apt-get update
echo
echo "Installing Pyrit..."
sudo apt-get install pyrit -y
echo
echo -e "\e[32mDONE\e[0m"
echo -e "To run Wifite type \"\e[33mpython /pentest/wireless/wifite/wifite.py\e[0m\""
