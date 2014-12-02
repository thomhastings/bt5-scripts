#/bin/sh
# this should only grab the massive wordlists for the dedicated install version not the live distro
cd ~
mkdir passwords
cd passwords
wget -N --no-check-certificate https://dazzlepod.com/site_media/txt/reusable.py
chmod +x reusable.py
cd wordlists/
wget http://wordlist-manipulator.googlecode.com/svn/wlm
mv wlm wlm.sh
chmod +x wlm.sh
wget -N http://dazzlepod.com/site_media/txt/passwords.txt
wget http://isdpodcast.com/files/62kcmnpass.tar.gz
tar -xvf 62kcmnpass.tar.gz
chmod -x 62kcmnpass.txt
rm 62kcmnpass.tar.gz
svn checkout http://svn.isdpodcast.com/wordlists InfoSecDaily & # this really is big
cd InfoSecDaily
tar xvf *.tar.gz
cd ..
mkdir SkullSecurity.org
cd SkullSecurity.org
wget -r -l1 -H -t1 -nd -N -np -A.bz2 -erobots=off http://www.skullsecurity.org/wiki/index.php/Passwords # this is really really big
bzip2 -dv *.bz2
cd ..
