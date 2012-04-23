#!/bin/sh
echo "Get my Favourite Scripts"
echo -e "\e[37m(c) Thom Hastings 2012 BSD-license\e[0m"
echo
echo -e "Creating directory \e[33m/pentest/scripts\e[0m and changing to it..."
mkdir /pentest/scripts
cd /pentest/scripts
echo
echo -e "Getting \e[33mphillips321\e[0m's scripts:"
svn checkout http://phillips321.googlecode.com/svn/trunk/ phillips321
echo
echo -e "Creating directory for \e[33mconfigitnow\e[0m's scripts..."
mkdir configitnow
cd configitnow
echo -e "Checking out \e[33mconfigitnow\e[0m's repositories:"
echo "1.) backtrack-update"
svn checkout http://backtrack-update.googlecode.com/svn/trunk/ backtrack-update
echo "2.) hydrafy"
svn checkout http://quickset.googlecode.com/svn/trunk hydrafy
echo "3.) quickset"
svn checkout http://quickset.googlecode.com/svn/trunk quickset
echo "4.) wifi-101"
svn checkout http://wifi-101.googlecode.com/svn/trunk wifi-101
cd ..
echo
echo -e "Getting \e[33mBl4ck5w4n\e[0m's update script:"
echo "Downloading..."
wget http://bl4ck5w4n.tk/wp-content/uploads/2011/07/bt5up.tar
echo "Decompressing..."
tar -xvf bt5up.tar
echo "Cleaning up..."
rm bt5up.tar
echo
echo -e "\e[32mDONE\e[0m"
echo -e "Run scripts from \e[33m/pentest/scripts\e[0m as:"
echo -e "\e[33mphillips321/pentest.sh\e[0m (pentest)"
echo -e "and \e[33mpython bt5up.py\e[0m (update)"
