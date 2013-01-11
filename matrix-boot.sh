#!/bin/sh
echo "Set Matrix 'Theme' (GRUB, Bootsplash, Plymouth & wallpaper) script"
echo "(c) Thom Hastings 2013 New BSD license"
echo "Original author: g0tmi1k"
echo


#--- GRUB
echo -e "Customizing \e[33mGRUB\e[0m and \e[33mBootSplash\e[0m..."
cd /usr/local/src/

echo -e "Downloading \e[33mGRUB\e[0m theme..."
if [ ! -e /usr/local/src/grub2-matrix-theme.tar.gz ]; then wget http://dl.dropbox.com/u/80562560/grub%20matrix%20theme/grub2-matrix-theme.tar.gz; fi

echo "Decompressing..."
tar xf grub2-matrix-theme.tar.gz
cd matrix/

echo -e "Installing... \e[33mtype 'y'\e[0m"
bash install.sh

echo -e "Altering \e[33mGRUB\e[0m settings (So we see it!)..."
if [ ! -e /lib/plymouth/themes/simple/bt5_1024x768.png.bkup ]; then cp -f /etc/default/grub{,.bkup}; fi
sed -i 's/^GRUB_HIDDEN_TIMEOUT=/#GRUB_HIDDEN_TIMEOUT=/' /etc/default/grub
sed -i 's/.*GRUB_HIDDEN_TIMEOUT_QUIET=.*/GRUB_HIDDEN_TIMEOUT_QUIET=false/' /etc/default/grub

echo "Running:  \e[33mupdate-grub\e[0m..."
update-grub

echo "Cleaning up..."
rm -rf /usr/local/src/{matrix/,grub2-matrix-theme.tar.gz}
echo


#--- Bootsplash
echo -e "Customizing \e[33mBootSplash\e[0m theme..."
cd /usr/local/src/

echo -e "Downloading \e[33mBootSplash\e[0m..."
if [ ! -e /usr/local/src/bootsplash-3.1.tar.bz2 ]; then wget ftp://ftp.bootsplash.org/pub/bootsplash/rpm-sources/bootsplash/bootsplash-3.1.tar.bz2; fi

echo "Decompressing..."
tar xjf bootsplash-3.1.tar.bz2
cd bootsplash-*/Utilities/

echo "Compiling \e[33mbootsplash\e[0m theme..."
make splash

echo "Downloading theme..."
mkdir -p /opt/bootsplash/themes/
cd /opt/bootsplash/themes/
if [ ! -e /usr/local/src/matrix-splash-v1.0.tar.gz ]; then wget http://matrixsplash.altervista.org/matrix-splash-v1.0.tar.gz; fi

echo "Decompressing..."
tar xf matrix-splash-v1.0.tar.gz
cd matrix-splash/

echo "Installing..."
if [ ! -e /opt/bootsplash/bootsplash.bkup ]; then cp -f /opt/bootsplash/bootsplash{,.bkup}; fi
if [ ! -e /opt/bootsplash/themes/matrix-splash/config/bootsplash-1024x768.cfg.bkup ]; then cp -f /opt/bootsplash/themes/matrix-splash/config/bootsplash-1024x768.cfg{,.bkup}; fi
sed -i 's/^jpeg=.*/jpeg=\/opt\/bootsplash\/themes\/matrix-splash\/images\/bootsplash-1024x768.jpg/' /opt/bootsplash/themes/matrix-splash/config/bootsplash-1024x768.cfg
sed -i 's/^silentjpeg=.*/silentjpeg=\/opt\/bootsplash\/themes\/matrix-splash\/images\/silent-1024x768.jpg/' /opt/bootsplash/themes/matrix-splash/config/bootsplash-1024x768.cfg
/usr/local/src/bootsplash-*/Utilities/splash -s -f /opt/bootsplash/themes/matrix-splash/config/bootsplash-1024x768.cfg > /opt/bootsplash/bootsplash

echo "Running: \e[33mfix-splash\e[0m..."
fix-splash

echo "Cleaning up..."
#rm -rf /usr/local/src/{bootsplash-3.1/,bootsplash-3.1.tar.bz2}
rm -rf /opt/bootsplash/themes/matrix-splash-v1.0.tar.gz


#--- Plymouth
echo -e "Customizing \e[33mPlymouth\e[0m theme..."
cd /lib/plymouth/themes/simple/

echo -e "Downloading \e[33mPlymouth\e[0m..."
if [ ! -e /lib/plymouth/themes/simple/bt5_1024x768.png.bkup ]; then cp -f /lib/plymouth/themes/simple/bt5_1024x768.png{,.bkup}; fi
if [ ! -e /lib/plymouth/themes/simple/miscellaneous-95767.jpeg ]; then wget http://www.n1tr0g3n.com/wp-content/uploads/2011/12/miscellaneous-95767.jpeg; fi #-O bt5_1024x768.png

echo "Converting plymouth..."
mogrify -density 72x72 -units PixelsPerInch miscellaneous-95767.jpeg
convert -resize 1024x768! miscellaneous-95767.jpeg /lib/plymouth/themes/simple/bt5_1024x768.png

echo "Applying image..."
update-alternatives --auto default.plymouth #update-alternatives --config default.plymouth
update-initramfs -u

echo "Running: \e[33mfix-splash\e[0m..."
fix-splash

echo "Cleaning up..."
rm -rf /lib/plymouth/themes/simple/miscellaneous-95767.jpeg


#--- Wallpaper (Need to restart xserver for it to take effect)
echo -e "Customizing \e[33mWallpaper\e[0m theme..."
cd /usr/share/wallpapers/backtrack/

echo -e "Downloading \e[33mPlymouth\e[0m..."
if [ ! -e /usr/share/wallpapers/backtrack/hacker_manifesto_mentor.jpg ]; then wget http://pip.cat/bloc/wp-content/uploads/2012/05/hacker_manifesto_mentor.jpg; fi

echo "Applying wallpaper..."
rm -f /root/Desktop/backtrack-install.desktop
gconftool-2 --type string --set /desktop/gnome/background/picture_filename /usr/share/wallpapers/backtrack/hacker_manifesto_mentor.jpg


#--- cmatrix
echo -e "Installing \e[32mcmatrix\e[0m just for fun"
apt-get -y install cmatrix
echo


#--- DONE!
echo
echo -e "\e[32mDONE\e[0m"
#reboot
