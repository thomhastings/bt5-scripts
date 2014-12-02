#!/bin/sh
cd /tmp
MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} = 'x86_64' ]
then
    URL="http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3066_amd64.deb"
else
    URL="http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3066_i386.deb"
fi
FILE="sublime.deb"
wget -N "$URL" -O $FILE && sudo dpkg -i $FILE -y
#rm $FILE
