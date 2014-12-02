#!/bin/sh
sudo apt-get install figlet -y
cd /etc/skel
mkdir txt
cd txt
wget -N http://www.textfiles.com/100/hack7.txt
wget -N http://textfiles.com/ufo/matrix.ufo -o matrix.ufo.txt
wget -N http://www.cyberdelix.net/tech/portlist.txt
wget -N http://www.phrack.com/issues.html?issue=42&id=13&mode=txt -o p42_0x0d_HoHoCon_by_various.txt
wget -N http://www.okean.com/chinacidr.txt
cd /usr/share/figlet
sudo wget -r -l1 -H -t1 -nd -N -np -A.flf -erobots=off http://www.textfiles.com/art/
cd ~
figlet -f graffiti "\"Welcome to the real world.\""
echo "                 - Morpheus, The Matrix"