#!/bin/sh
echo "Get Audacious & Skins Script"
echo "(c) Thom Hastings 2012 New BSD License"
echo
echo "Installing Audacious..."
sudo apt-get install audacious -y
echo
echo "Getting some skins..."
cd /usr/share/audacious/Skins/
wget http://files.customize.org/download/files/44608/SosoundDarkandGreen1-0_1142391900.wsz
wget http://www.winampskins.info/getfile/1411/TWS_Sunburn.wsz
echo
echo "Getting a playlist..."
cd ~/.config/audacious/playlists/
wget http://haxradio.com/files/haxradio.pls
cd ..
echo
echo "Configuring skin..."
sed -c -i "s/\(skin *= *\).*/\1/usr/share/audacious/Skins/SosoundDarkandGreen1-0_1142391900.wsz/" config
echo
echo "Writing shortcut..."
cd /usr/share/icons/
wget https://si0.twimg.com/profile_images/1765985637/haxradio.png
cd ~/Desktop/
echo "[Desktop Entry]" >> haxradio-listen.desktop
echo "Name=Listen to HaxRadio" >> haxradio-listen.desktop
echo "Encoding=UTF-8" >> haxradio-listen.desktop
echo "Exec=sh -c \"audacious ~/.config/audacious/playlists/haxradio.pls\"" >> haxradio-listen.desktop
echo "Icon=haxradio.png" >> haxradio-listen.desktop
echo "StartupNotify=false" >> haxradio-listen.desktop
echo "Terminal=false" >> haxradio-listen.desktop
echo "Type=Application" >> haxradio-listen.desktop
echo "Categories=HaxRadio;" >> haxradio-listen.desktop
echo
echo "DONE"
