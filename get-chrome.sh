#!/bin/sh
echo -e "Get \e[34mG\e[31mo\e[33mo\e[34mg\e[32ml\e[31me\e[37m Chrome\e[0m script"
echo "(c) Thom Hastings 2013 New BSD license"
echo
echo -e "Getting \e[34mG\e[31mo\e[33mo\e[34mg\e[32ml\e[31me\e[37m Chrome\e[0m..."
cd ~
MACHINE_TYPE=`uname -m`
echo -e "Machine type is \e[37m$MACHINE_TYPE\e[0m"
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  echo "Downloading 64-bit..."
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
else
  echo "Downloading 32-bit..."
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
fi
echo "Installing..."
sudo dpkg -i ./google-chrome*.deb
echo "Resolving dependencies..."
sudo apt-get -f install -y
echo "Cleaning up..."
rm google-chrome*.deb
echo "Fixing run-as-root issue..." # doesn't work yet
sed -i 's/exec.*/& --user-data-dir/g' /usr/bin/google-chrome
echo
echo -e "\e[32mDONE\e[0m"
echo -e "You will have to run \"\e[33msed -i 's/exec.*/& --user-data-dir/g' /usr/bin/google-chrome\e[0m\" after each Chrome upgrade."
