#!/bin/sh
echo -e "\e[31mBack|Track 5r3\e[0m Post-Install Script"
echo -e "\e[37m(c) Thom Hastings 2012 New BSD license\e[0m"
echo
echo -e "Getting \e[33mTor\e[0m..."
sh get-tor.sh
echo
echo -e "Getting \e[33mFiglet\e[0m..."
sh get-figlet.sh
#echo  # This takes forever.
#echo -e "Getting \e[33mwordlists\e[0m..."
#sh get-wordlists.sh
echo
echo -e "Getting \e[33mscripts\e[0m..."
sh get-scripts.sh
echo
echo -e "Installing \e[33mGuake\e[0m & \e[33mTilda\e[0m..."
apt-get install guake tilda -y
echo
echo -e "Getting \e[36mDropbox\e[0m..."
sh get-dropbox.sh
echo
echo -e "Getting \e[34mG\e[31mo\e[33mo\e[34mg\e[32ml\e[31me\e[37m Chrome\e[0m..."
sh get-chrome.sh
echo
echo "Grabbing a few wallpapers..."
cd /usr/share/wallpapers/backtrack/
wget http://www.n1tr0g3n.com/wp-content/uploads/2011/12/Fucking-ninja-is-Bad-ass.jpg
wget http://www.n1tr0g3n.com/wp-content/uploads/2011/12/matrix_hacker_by_zahid4world-d3dyf5r2.jpg
wget http://www.n1tr0g3n.com/wp-content/uploads/2011/12/miscellaneous-95767.jpeg
wget http://www.n1tr0g3n.com/wp-content/uploads/2011/12/wallpaper-1000423.png
wget http://pip.cat/bloc/wp-content/uploads/2012/05/hacker_manifesto_mentor.jpg
wget http://www.wallpaper4me.com/images/wallpapers/sexyteacher-376799.jpeg
echo
echo -e "Setting \e[32mMatrix\e[0m Boot..."
sh matrix-boot.sh
echo
echo -e "Getting \e[32mAudacious\e[0m..."
sh get-audacious.sh
echo
echo "Cleaning up..."
apt-get autoremove -y
echo
echo -e "Updating \e[31mBack|Track\e[0m..."
python /pentest/scripts/bt5up.py
echo
echo -e "\e[32mDONE\e[0m"
