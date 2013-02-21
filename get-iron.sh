#!/bin/sh
echo "Get SRware Iron script"
echo "(c) Thom Hastings 2013 New BSD license"
echo
echo "Downloading & installing SRware Iron..."
cd ~
MACHINE_TYPE=`uname -m`
echo -e "Machine type is \e[37m$MACHINE_TYPE\e[0m"
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  echo "Downloading 64-bit..."
  URL="http://www.srware.net/downloads/iron64.deb"
else
  echo "Downloading 32-bit..."
  URL="http://www.srware.net/downloads/iron64.deb"
fi
FILE="iron.deb"
wget "$URL" -qO $FILE && echo "Installing..." && sudo dpkg -i $FILE
echo "Cleaning up..."
rm $FILE
echo
echo -e "\e[32mDONE\e[0m"
