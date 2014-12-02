#!/bin/sh
# relevant documentation: https://tails.boum.org/todo/windows_theme/
# relevant documentation: http://docs.kali.org/live-build/customize-the-kali-desktop-environment
cd /usr/share/backgrounds/gnome/
sudo wget -N http://www.n1tr0g3n.com/wp-content/uploads/2011/12/Green_dragon_by_archstroke.png -O AttackVector.png
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/gnome/AttackVector.png
cd /usr/share/themes/
sudo apt-get install p7zip -y
sudo wget -N http://fc00.deviantart.net/fs71/f/2009/342/a/0/Gnome_Buuf_Deuce_1_1_R8_by_djany.7z -O buuf_deuce.7z
p7zip -d buuf_deuce.7z
sudo mv Buuf-Deuce-1.1-R8.tar.bz2 buuf_deuce.tar.bz2
sudo tar xvf buuf_deuce.tar.bz2
sudo rm buuf_deuce.tar.bz2
sudo chmod 755 Buuf-Deuce
gsettings set org.gnome.desktop.interface icon-theme Buuf-Deuce
sudo wget -N http://gnome-look.org/CONTENT/content-files/108928-terminus.tar.gz -O terminus.tar.gz
sudo tar xvf terminus.tar.gz
sudo rm terminus.tar.gz
sudo mv terminus Terminus
gsettings set org.gnome.desktop.wm.preferences theme Terminus
gsettings set org.gnome.desktop.interface gtk-theme Terminus
sudo wget -N http://gnome-look.org/CONTENT/content-files/127846-AlienWare.tar.gz -O alien.tar.gz
sudo tar xvf alien.tar.gz
sudo rm terminus.tar.gz
