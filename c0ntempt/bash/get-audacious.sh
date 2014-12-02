#!/bin/sh
sudo apt-get install -y audtty audacious audacious-plugins
cd /usr/share/audacious/Skins/
wget -N http://files.customize.org/download/files/44608/SosoundDarkandGreen1-0_1142391900.wsz
mv SosoundDarkandGreen{1-0_1142391900,}.wsz
wget -N http://www.winampskins.info/getfile/1411/TWS_Sunburn.wsz
/usr/bin/audacious &
sleep 1
killall audacious
cd /usr/share/audacious/
wget -N http://haxradio.com/scripts/playlist.pls
cd ~/.config/audacious/
sed -i 's/.*skin=.*/skin=\/usr\/share\/audacious\/Skins\/TWS_Sunburn.wsz/' config
cd /usr/share/icons/
wget -N https://si0.twimg.com/profile_images/1765985637/haxradio.png
cd ~/.config/audacious/
echo '<?xml version="1.0" encoding="UTF-8"?>' > playlist.xspf
echo '<playlist version="1" xmlns="http://xspf.org/ns/0/">' >> playlist.xspf
echo "<creator>audacious-plugins-2.3</creator>" >> playlist.xspf
echo "<title>Untitled Playlist</title>" >> playlist.xspf
echo "<trackList>" >> playlist.xspf
echo "<track>" >> playlist.xspf
echo "<location>`curl http://haxradio.com/scripts/playlist.pls | grep .mp3 | awk -F= '{ print $2 }'`</location>" >> playlist.xspf
echo "<title>HaxRadio</title>" >> playlist.xspf
echo "<album>haxradio</album>" >> playlist.xspf
echo "<meta rel="bitrate">128</meta>" >> playlist.xspf
echo "</track0>" >> playlist.xspf
echo "</trackList>" >> playlist.xspf
echo "</playlist>" >> playlist.xspf
cd ~/Desktop/
echo '#!/usr/bin/env xdg-open' > haxradio-listen.desktop
echo "" >> haxradio-listen.desktop
echo "[Desktop Entry]" > haxradio-listen.desktop
echo "Name=Listen to HaxRadio" >> haxradio-listen.desktop
echo "Encoding=UTF-8" >> haxradio-listen.desktop
echo "Exec=/usr/bin/audacious /usr/share/audacious/playlist.pls" >> haxradio-listen.desktop
echo "Icon=/usr/share/icons/haxradio.png" >> haxradio-listen.desktop
echo "StartupNotify=false" >> haxradio-listen.desktop
echo "Terminal=false" >> haxradio-listen.desktop
echo "Type=Application" >> haxradio-listen.desktop
echo "Categories=HaxRadio;" >> haxradio-listen.desktop
chmod +x haxradio-listen.desktop
