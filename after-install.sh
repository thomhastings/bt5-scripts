#!/bin/sh
#echo -e "\e[31mBack|Track 5r3\e[0m Post-Install Script"
echo -e "\e[37m(c) Thom Hastings 2012-2013 New BSD license\e[0m"
SCRIPTPATH=`pwd`
echo
#echo "Deleting that pesky install icon..."
#rm -f /root/Desktop/backtrack-install.desktop
cd /etc/skel
echo
echo "Getting Vim just the way I like it..."
git clone git://github.com/thomhastings/vim.git
mv vim/vimrc .vimrc
mv vim .vim
cd $SCRIPTPATH
#echo
#echo -e "Installing \e[33mGuake\e[0m & \e[33mTilda\e[0m..."
#apt-get install guake tilda -y
#echo
#echo -e "Getting \e[32mTor\e[0m..."
#sh get-tor.sh
#echo
#echo "Getting SRware Iron..."
#sh get-iron-browser.sh
#echo
#echo -e "Getting \e[33mFiglet\e[0m..."
#sh get-figlet.sh
#echo
#echo -e "Getting \e[36mDropbox\e[0m..."
#sh get-dropbox.sh
#echo
#echo -e "Getting \e[32mAudacious\e[0m..."
#sh get-audacious.sh
echo
echo "Grabbing a few wallpapers..."
cd /usr/share/wallpapers/
wget -N http://onlyhdwallpapers.com/wallpaper/abstract_blue_matrix_binary_digital_art_desktop_1920x1080_hd-wallpaper-747379.jpg
wget -N http://www.n1tr0g3n.com/wp-content/uploads/2011/12/matrix_hacker_by_zahid4world-d3dyf5r2.jpg
wget -N http://www.n1tr0g3n.com/wp-content/uploads/2011/12/Craptrack-5-r3_by-n1tr0g3n.jpg
wget -N http://www.n1tr0g3n.com/wp-content/uploads/2011/12/Green_dragon_by_archstroke.png
wget -N http://www.n1tr0g3n.com/wp-content/uploads/2011/12/Fucking-ninja-is-Bad-ass.jpg
wget -N http://www.n1tr0g3n.com/wp-content/uploads/2011/12/miscellaneous-95767.jpeg
wget -N http://www.n1tr0g3n.com/wp-content/uploads/2011/12/wallpaper-1000423.png
wget -N http://pip.cat/bloc/wp-content/uploads/2012/05/hacker_manifesto_mentor.jpg
wget -N http://www.wallpaper4me.com/images/wallpapers/sexyteacher-376799.jpeg
cd $SCRIPTPATH
#echo
#echo -e "Setting \e[32mMatrix\e[0m Boot..."
#sh matrix-boot.sh
#echo
#echo -e "Getting \e[33mscripts\e[0m..."
#sh get-scripts.sh
#echo
#echo "Cleaning up..."
#apt-get autoremove -y && apt-get clean
#echo
#echo -e "Getting \e[33mwordlists\e[0m..."
#sh get-wordlists.sh & # this takes forever
#echo
#echo -e "Updating \e[31mBack|Track\e[0m..."
#python /pentest/bt5up/bt5up.py
echo
echo -e "\e[32mDONE\e[0m"
