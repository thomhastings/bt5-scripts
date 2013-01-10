#!/bin/sh
echo "Get Audacious & Skins Script"
echo "(c) Thom Hastings 2012 New BSD License"
echo
echo "Installing Audacious..."
sudo apt-get install audtty audacious audacious-plugins -y
echo
echo "Getting some skins..."
cd /usr/share/audacious/Skins/
wget -N http://files.customize.org/download/files/44608/SosoundDarkandGreen1-0_1142391900.wsz
mv SosoundDarkandGreen1-0_1142391900.wsz SosoundDarkandGreen.wsz
wget -N http://www.winampskins.info/getfile/1411/TWS_Sunburn.wsz
echo
echo "Starting Audacious... (to generate config files)"
/usr/bin/audacious &
echo "Waiting 3 seconds..."
sleep 3
echo "Killing Audacious..."
killall audacious
echo
echo "Getting a playlist..."
cd ~/.config/audacious/playlists/
wget -N http://haxradio.com/scripts/playlist.pls
cd ..
echo
echo "Configuring skin..."
sed -i "s#\(skin *= *\).*#\0/usr/share/audacious/Skins/TWS_Sunburn.wsz#" config
echo
echo "Writing shortcut..."
cd /usr/share/icons/
wget -N https://si0.twimg.com/profile_images/1765985637/haxradio.png
cd ~/Desktop/
echo "[Desktop Entry]" > haxradio-listen.desktop
echo "Name=Listen to HaxRadio" >> haxradio-listen.desktop
echo "Encoding=UTF-8" >> haxradio-listen.desktop
echo "Exec=audacious ~/.config/audacious/playlists/haxradio.pls" >> haxradio-listen.desktop
echo "Icon=/usr/share/icons/haxradio.png" >> haxradio-listen.desktop
echo "StartupNotify=false" >> haxradio-listen.desktop
echo "Terminal=false" >> haxradio-listen.desktop
echo "Type=Application" >> haxradio-listen.desktop
echo "Categories=HaxRadio;" >> haxradio-listen.desktop
cd ..
echo
echo "DONE"
