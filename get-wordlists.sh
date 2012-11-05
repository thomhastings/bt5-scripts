#/bin/sh
echo "Get Wordlists script"
echo -e "\e[37m(c) Thom Hastings 2012 New BSD license\e[0m"
echo -e "designed for \e[31mBack|Track 5r2\e[0m"
cd /pentest/passwords/wordlists
echo
echo -e "Downloading \e[33mg0tmi1k\e[0m's 500-worst-passwords.txt"
wget https://g0tmi1k.googlecode.com/svn/trunk/wordlists/500-worst-passwords.txt
echo
echo -e "Downloading \e[33mUNIQPASS\e[0m passwords.txt"
wget http://dazzlepod.com/site_media/txt/passwords.txt
echo
echo -e "Downloading \e[33mskullsecurity.org\e[0m wordlists"
wget -r -l1 -H -t1 -nd -N -np -A.bz2 -erobots=off http://www.skullsecurity.org/wiki/index.php/Passwords
echo "Decompressing..."
bzip2 -dv *.bz2
echo
echo -e "Downloading \e[33m62kcmnpass\e[0m..."
wget http://isdpodcast.com/files/62kcmnpass.tar.gz
echo "Decompressing..."
tar -xvf 62kcmnpass.tar.gz
echo "Cleaning up..."
rm 62kcmnpass.tar.gz
# *** COMMENTED OUT BECAUSE THIS WORDLIST COLLECTION IS SIMPLY TOO BIG ***
#echo -e "Checking out \e[33misdpodcast\e[0m wordlist repository (BIG)..."
#svn checkout http://svn.isdpodcast.com/wordlists wordlists
echo
echo -e "\e[32mDONE\e[0m"
