#!/bin/sh
echo "Get Figlet script"
echo -e "\e[37m(c) Thom Hastings 2011 New BSD license\e[0m"
echo
echo "Updating repositories..."
sudo apt-get update
echo
echo "Installing Figlet..."
sudo apt-get install figlet -y
echo
echo "Getting Figlet fonts..."
cd /usr/share/figlet
sudo wget -r -l1 -H -t1 -nd -N -np -A.flf -erobots=off http://www.textfiles.com/art/
cd ~
figlet -f graffiti "\"Welcome to the real world.\""
echo -e "             - Morpheus, \e[32mThe Matrix\e[0m"
