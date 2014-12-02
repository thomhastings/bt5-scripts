#!/bin/sh
echo "Get my Favourite Scripts -- openSUSE edition!"
echo -e "\e[37m(c) Thom Hastings 2012-2013 New BSD license\e[0m"
echo
echo -e "Installing prerequisites: (\e[33mp7zip\e[0m and \e[33mmercurial\e[0m)..."
sudo zypper install p7zip mercurial git-core htop screen vim lynx
echo
echo -e "Creating directory \e[33m/pentest/scripts\e[0m and changing to it..."
mkdir /tmp/pen/scripts
cd /tmp/pen/scripts
echo
echo -e "Cloning \e[33mmallory\e[0m..."
hg clone https://bitbucket.org/IntrepidusGroup/mallory
echo
echo -e "Cloning \e[33mDotDotPwn\e[0m..."
git clone git://github.com/wireghoul/dotdotpwn.git
echo
echo -e "Cloning \e[33mLORCON\e[0m..."
git clone https://code.google.com/p/lorcon
cd lorcon
git clone git://github.com/tom5760/pylorcon2.git
cd ..
echo
echo -e "Cloning \e[33mOWTF\e[0m..."
git clone git://github.com/7a/owtf.git
echo
echo -e "Cloning \e[33momphalos\e[0m..."
git clone git://github.com/dankamongmen/omphalos.git
echo
echo -e "Cloning \e[33mRecon-ng\e[0m..."
git clone https://bitbucket.org/LaNMaSteR53/recon-ng.git
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
echo -e "Creating directory for \e[33mSCADA\e[0m tools..."
mkdir scada
cd scada
echo -e "Getting \e[33mSCADA\e[0m tools:"
echo -e "1.) PLCscan"
svn checkout http://plcscan.googlecode.com/svn/trunk/ plcscan
cd plcscan
chmod +x *.py
cd ..
echo -e "2.) WinCC harvester"
git clone git://github.com/nxnrt/wincc_harvester.git
cd wincc_harvester
echo "Installing metasploit module"
cp wincc_harvester.rb /opt/metasploit/msf3/modules/auxiliary/admin/scada/
cd ..
echo -e "3.) s7-brute-offline.py"
wget http://pastebin.com/raw.php?i=0G9Q2k6y
mv raw.php\?i\=0G9Q2k6y s7-brute-offline.py
chmod +x s7-brute-offline.py
cd ..
echo
echo -e "Getting \e[33mPenTBox\e[0m..."
svn checkout https://pentbox.svn.sourceforge.net/svnroot/pentbox/trunk pentbox
echo
echo -e "Getting \e[33mphillips321\e[0m's scripts..."
svn checkout http://phillips321.googlecode.com/svn/trunk phillips321
cd phillips321
svn checkout http://bt5-fixit.googlecode.com/svn/trunk/ bt5
cd ..
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
echo -e "Getting \e[33mJosh Begleiter\e[0m's cgi-scanner.py:"
wget http://josh.myhugesite.com/static/docs/cgi-scanner.py
chmod +x cgi-scanner.py
echo
echo -e "Getting \e[33mAlexander Hanel\e[0m's extflow.py:"
wget http://codepad.org/BYdtDf9c/raw.py
mv raw.py extflow.py
chmod +x extflow.py
mkdir hax
cd hax
git clone git://github.com/thomhastings/rice ice
