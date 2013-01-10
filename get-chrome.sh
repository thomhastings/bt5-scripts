#!/bin/sh
echo -e "Get \e[34mG\e[31mo\e[33mo\e[34mg\e[32ml\e[31me\e[37m Chrome\e[0m script"
echo "(c) Thom Hastings 2013 New BSD license"
echo
echo -e "Getting \e[34mG\e[31mo\e[33mo\e[34mg\e[32ml\e[31me\e[37m Chrome\e[0m..."
MACHINE_TYPE=`uname -m`
echo -e "Machine type is \e[37m$MACHINE_TYPE\e[0m"
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  echo "Downloading 64-bit..."
  wget -O - ""
else
  echo "Downloading 32-bit..."
  wget -O - ""
fi
echo "Installing..."

sed -i 's/exec.*/& --user-data-dir/g' /usr/bin/google-chrome
echo
echo -e "\e[32mDONE\e[0m"
echo -e "You will have to run \"\e[33msed -i 's/exec.*/& --user-data-dir/g' /usr/bin/google-chrome\e[0m\" again with each Chrome upgrade."
