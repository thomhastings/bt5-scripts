#/bin/sh
echo "Get Wordlists script"
echo -e "\e[37m(c) Thom Hastings 2012-2013 New BSD license\e[0m"
echo -e "designed for \e[31mBack|Track 5r3\e[0m"
cd /pentest/passwords/
echo
echo -e "Getting \e[33mreusable.py\e[0m"
wget -N --no-check-certificate https://dazzlepod.com/site_media/txt/reusable.py
chmod +x reusable.py
cd wordlists/
echo
echo -e "Getting \e[33mTAPE\e[0m's wordlist-maniuplator '\e[32mwlm.sh\e[0m'"
wget http://wordlist-manipulator.googlecode.com/svn/wlm
mv wlm wlm.sh
chmod +x wlm.sh
echo
echo -e "Downloading \e[33mUNIQPASS\e[0m passwords.txt"
wget -N http://dazzlepod.com/site_media/txt/passwords.txt
echo
wget http://isdpodcast.com/files/62kcmnpass.tar.gz
echo "Decompressing..."
tar -xvf 62kcmnpass.tar.gz
echo "Cleaning up..."
chmod -x 62kcmnpass.txt
rm 62kcmnpass.tar.gz
echo
firefox "http://bit.do/openwall"
echo -e "Checking out \e[33mInfoSecDaily\e[0m wordlist repository (\e[31mBIG\e[0m)..."
svn checkout http://svn.isdpodcast.com/wordlists InfoSecDaily & # this really is big
echo
echo -e "Downloading \e[33mskullsecurity.org\e[0m wordlists (\e[31mEVEN BIGGER\e[0m)..."
mkdir SkullSecurity.org
cd SkullSecurity.org
wget -r -l1 -H -t1 -nd -N -np -A.bz2 -erobots=off http://www.skullsecurity.org/wiki/index.php/Passwords # this is really really big
echo "Decompressing..."
bzip2 -dv *.bz2
cd ..
echo
echo -e "\e[32mDONE\e[0m"
