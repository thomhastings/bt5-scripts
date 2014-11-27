#!/bin/bash
clear
echo
echo
echo
echo "              888888b. 88888888888      888888888       888     888               888          888";                    
echo "              888   88b    888          888             888     888               888          888";                    
echo "              888   88P    888          888             888     888               888          888";                    
echo "              8888888K     888          8888888b        888     888 88888b     d88888  8888b   888888  d88b   888d888"; 
echo "              888   Y88b   888                Y88b      888     888 888 88b  d88888        88b 888   d8P  Y8b 888P";   
echo "              888    888   888                 888      888     888 888  888 888  888  d888888 888   88888888 888";     
echo "              888   d88P   888          Y88b  d88P      Y88b  d88P 888 d88P  Y88b 888 888  888 Y88b   Y8b     888";    
echo "              8888888P     888            Y8888P          Y88888P  88888P      Y88888  Y888888  Y888    Y8888  888";    
echo "                                                                   888";                                               
echo "                                                                   888";                                               
echo "                                                                   888"; 
echo ""
echo ""

echo "                                                N1tr0g3n's BT 5 R3 update script"
                                          
echo "                                                      Created by: N1tr0g3n"
                               
echo "                                       Website : www.n1tr0g3n.com || www.top-hat-sec.com"
echo 
sleep 5
clear

echo ""
echo ""
echo ""
echo "                This script will update Backtrack with a bunch of tools that it should have came with in the first place"
echo


echo "                                       The tools that are installed are as shown below"
echo


echo "                          Ubuntu software Center   Update manager    Synaptic   Nautilus Open Terminal";
echo
echo "                            Remove Annoying Mail icon  GTK record My Desktop  Airodump-ng  Bleachbit";
echo
echo "                                    SMPlayer Update Aircrack-ng Install SSLStrip File Roller"; 
echo
echo "                                              run all Backtrack updates & lots more";
echo 
read -p "                                         Please press ENTER to continue with the script"
clear

# This will install Gnome-Tweak-Tool
sudo add-apt-repository ppa:tualatrix/ppa &

sudo apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y
clear

sudo apt-get install ubuntu-tweak -y
clear

# This will install Vlc Player & Mozilla Plugin
sudo apt-get install vlc vlc-plugin-pulse mozilla-plugin-vlc -y
clear

# This will remove the annoying Mail icon "only" from the menu bar
sudo apt-get remove indicator-me indicator-messages -y
clear

# This will install Software-Center     
sudo apt-get install software-center -y
clear

# This will install update manager to run Ubuntu updates
sudo apt-get install update-manager -y
clear

# This will install Update Manager
sudo apt-get install update-manager -y
clear

# this will install Gdebi package installer
sudo apt-get install gdebi -y
clear

# this ill install Synaptic Package Manager
sudo apt-get install synaptic -y
clear

# This will install Nautilus right click open in terminal
sudo apt-get install nautilus-open-terminal -y
clear

#This will install Smplayer
sudo apt-get install smplayer -y
clear

# this will install GTK- Record My desktop 
sudo apt-get install gtk-recordmydesktop -y
clear

# This will install Bleachbit Cleaner
sudo apt-get install bleachbit -y
clear

# this will install Archive Manager "File Roller"
sudo apt-get install file-roller -y
clear

# This will update aircrack-ng
sudo airodump-ng-oui-update

clear
echo "                              [+]Installing SSLstrip[+]......"
sleep 3
cd /pentest/web/sslstrip
sudo python setup.py install
clear

echo "                        [+]Installing Looks Like XP Skins[+]....."
sleep 3 
cd /root/
wget http://www.phillips321.co.uk/downloads/LookLikeXP.deb
sudo dpkg -i LookLikeXP.deb
clear
rm LookLikeXP.deb
clear

# This will update all SVN's in the pentest folder.

find $pentest/ -maxdepth 5 -type d -name ".svn" -type d -ls -exec svn update {}/.. \;

echo ""
echo ""
echo ""
echo "       Please log off and back on for certain installs to take effect like Remove mail icon and Nautilus Open Terminal"



read -p "             To log off now press ENTER save all your work & close all windows before continuing"
        
sudo sudo pkill X
clear
exit
