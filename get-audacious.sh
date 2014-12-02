#!/bin/sh
echo "Get Audacious & Skins Script"
echo "(c) Thom Hastings 2013 New BSD License"
echo -e "Hint or two from \e[37mg0tmi1k\e[0m :)"
echo
echo "Installing Audacious..."
sudo zypper install audtty audacious audacious-plugins
echo
echo "Getting some skins..."
cd /usr/share/audacious/Skins/
wget -N http://files.customize.org/download/files/44608/SosoundDarkandGreen1-0_1142391900.wsz
mv SosoundDarkandGreen{1-0_1142391900,}.wsz
wget -N http://www.winampskins.info/getfile/1411/TWS_Sunburn.wsz
echo
echo "Starting Audacious... (to generate config files)"
/usr/bin/audacious &
echo "Waiting 1 second..."
sleep 1
echo "Killing Audacious..."
killall audacious
echo
echo "Getting a playlist..."
cd ~/.config/audacious/playlists/
wget -N http://haxradio.com/scripts/playlist.pls
cd ..
echo
echo "Configuring skin..."
sed -i 's/.*skin=.*/skin=\/usr\/share\/audacious\/Skins\/TWS_Sunburn.wsz/' config
echo
echo "Writing shortcut..."
cd /usr/share/icons/
wget -N https://si0.twimg.com/profile_images/1765985637/haxradio.png
cd ~/Desktop/
echo '#!/usr/bin/env xdg-open' > haxradio-listen.desktop
echo "" >> haxradio-listen.desktop
echo "[Desktop Entry]" > haxradio-listen.desktop
echo "Name=Listen to HaxRadio" >> haxradio-listen.desktop
echo "Encoding=UTF-8" >> haxradio-listen.desktop
echo "Exec=/usr/bin/audacious ~/.config/audacious/playlists/haxradio.pls" >> haxradio-listen.desktop
echo "Icon=/usr/share/icons/haxradio.png" >> haxradio-listen.desktop
echo "StartupNotify=false" >> haxradio-listen.desktop
echo "Terminal=false" >> haxradio-listen.desktop
echo "Type=Application" >> haxradio-listen.desktop
echo "Categories=HaxRadio;" >> haxradio-listen.desktop
chmod +x haxradio-listen.desktop
echo
echo -e "\e[32mDONE\e[0m"
