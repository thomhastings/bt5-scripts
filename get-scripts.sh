#!/bin/sh
echo "Get my Favourite Scripts"
echo -e "\e[37m(c) Thom Hastings 2012 New BSD license\e[0m"
echo
echo -e "Creating directory \e[33m/pentest/scripts\e[0m and changing to it..."
mkdir /pentest/scripts
cd /pentest/scripts
echo
echo -e "Cloning \e[33mmallory\e[0m..."
hg clone https://bitbucket.org/IntrepidusGroup/mallory
echo
echo -e "Cloning \e[33momphalos\e[0m..."
git clone git://github.com/dankamongmen/omphalos.git
echo
echo -e "Cloning \e[33mschadcode\e[0m..."
git clone git://github.com/emboss/schadcode.git
echo
echo -e "Cloning \e[33mwebhandler\e[0m..."
git clone git://github.com/lnxg33k/webhandler.git
cd webhandler
echo "Installing..."
python setup.py install
cd ..
echo
echo -e "Getting \e[33mmimikatz\e[0m..."
mkdir mimikatz
cd mimikatz
echo "Installing prerequisites..."
apt-get install p7zip -y
echo "Downloading..."
wget http://blog.gentilkiwi.com/downloads/mimikatz_trunk.7z
echo "Decompressing..."
p7zip -d mimikatz_trunk.7z
cd ..
echo
echo -e "Getting \e[33mPenTBox\e[0m..."
svn checkout https://pentbox.svn.sourceforge.net/svnroot/pentbox/trunk pentbox
echo
echo -e "Getting \e[33mphillips321\e[0m's scripts..."
svn checkout http://phillips321.googlecode.com/svn/trunk phillips321
echo
echo -e "Getting \e[33mg0tmi1k\e[0m's scripts..."
svn checkout http://g0tmi1k.googlecode.com/svn/trunk g0tmi1k
cd g0tmi1k
echo -e "\e[33mfakeap-pwn\e[0m..."
svn checkout http://fakeap-pwn.googlecode.com/svn/trunk fakeap-pwn
cd ..
echo
echo -e "Creating directory for \e[33mSnafu\e[0m's scripts..."
mkdir Snafu
cd Snafu
echo -e "Checking out \e[33mSnafu\e[0m's repositories individually:"
echo "1.) backtrack-update"
svn checkout http://backtrack-update.googlecode.com/svn/trunk backtrack-update
echo "2.) hydrafy"
svn checkout http://hydrafy.googlecode.com/svn/trunk hydrafy
echo "3.) quickset"
svn checkout http://quickset.googlecode.com/svn/trunk quickset
echo "4.) wifi-101"
svn checkout http://wifi-101.googlecode.com/svn/trunk wifi-101
cd ..
mkdir pentestgeek
cd pentestgeek
echo -e "Cloning \e[33mpentestgeek\e[0m scripts..."
git clone git://github.com/pentestgeek/scripts.git
echo -e "\e[33mjigsaw\e[0m..."
git clone git://github.com/pentestgeek/jigsaw.git
cd ..
echo
echo -e "Getting \e[33mAlexander Hanel\e[0m's extflow.py:"
wget http://codepad.org/TfQst1Lu/raw.py
mv raw.py extflow.py
chmod +x extflow.py
#echo  # This whole section needs fixing or removal. Oh Rel1k
#echo -e "Getting tools from from \e[33mTrustedSec\e[0m..."
#mkdir TrustedSec
#cd TrustedSec
#wget -r -l1 -H -t1 -nd -N -np -A.zip -erobots=off https://www.trustedsec.com/downloads/tools-download/ # -H argument is supposed to span hosts. why doesn't it?
#unzip *.zip
#echo -e "Checking out \e[33mTrustedSec\e[0m's \'Artillery\' honeypot..."
#svn checkout http://svn.trustedsec.com/artillery artillery # this is unnecessary in this context
#echo "Installing..."
#cd artillery
#python setup.py
#cd ..
#echo "Cleaning up..."
#rm -rf artillery
cd ..
echo
echo -e "Getting \e[33mBl4ck5w4n\e[0m's update script:"
mkdir /pentest/bt5up/
cd /pentest/bt5up/
echo "Downloading..."
wget http://bl4ck5w4n.tk/wp-content/uploads/2011/07/bt5up.tar
echo "Decompressing..."
tar -xvf bt5up.tar
echo "Cleaning up..."
rm bt5up.tar
echo
echo "Cleaning up more..."
apt-get autoremove -y
echo
echo -e "\e[32mDONE\e[0m"
echo -e "Run scripts from \e[33m/pentest/scripts\e[0m as:"
echo -e "\e[33mphillips321/pentest.sh\e[0m (pentest)"
