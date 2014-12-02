#!/bin/sh
echo "Get Figlet script"
echo "(c) Thom Hastings 2011 New BSD license"
echo
echo "Installing Figlet..."
sudo zypper install figlet
echo
echo "Getting Figlet fonts..."
cd /usr/share/figlet
sudo wget -r -l1 -H -t1 -nd -N -np -A.flf -erobots=off http://www.textfiles.com/art/
cd ~
figlet -f graffiti "\"Welcome to the real world.\""
echo "                 - Morpheus, The Matrix"
