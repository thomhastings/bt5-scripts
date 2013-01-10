#!/bin/sh
echo -e "Get \e[36mDropbox\e[0m script"
echo "(c) Thom Hastings 2013 New BSD license"
echo
echo -e "Downloading & installing \e[36mDropbox\e[0m..."
echo "Getting prerequisites..."
apt-get install python-gpgme -y
cd ~
MACHINE_TYPE=`uname -m`
echo -e "Machine type is \e[37m$MACHINE_TYPE\e[0m"
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  echo "Downloading 64-bit..."
  wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
else
  echo "Downloading 32-bit..."
  wget -O - "https://www.dropbox.com/download?plat=lnx.x86" | tar xzf -
fi
echo "Installing..."
echo -e "Starting Dropbox installer-- \e[33mfollow instructions\e[0m!"
exec ~/.dropbox-dist/dropboxd
echo "Cleaning up..."
rm -rf ~/.dropbox-dist
echo
echo "\e[32mDONE\e[0m"
