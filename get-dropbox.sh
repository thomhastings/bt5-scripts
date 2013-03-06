#!/bin/sh
echo -e "Get \e[36mDropbox\e[0m script"
echo "(c) Thom Hastings 2013 New BSD license"
echo
echo -e "Downloading & installing \e[36mDropbox\e[0m..."
echo "Getting prerequisites..."
sudo apt-get install python-gpgme -y
cd ~
MACHINE_TYPE=`uname -m`
echo -e "Machine type is \e[37m$MACHINE_TYPE\e[0m"
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  echo "Downloading 64-bit..."
  URL="https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.4.0_amd64.deb"
else
  echo "Downloading 32-bit..."
  URL="https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.4.0_i386.deb"
fi
FILE="dropbox-installer.deb"
wget "$URL" -qO $FILE && echo "Installing..." && sudo dpkg -i $FILE
echo "Cleaning up..."
rm $FILE
echo
echo -e "\e[32mDONE\e[0m"
