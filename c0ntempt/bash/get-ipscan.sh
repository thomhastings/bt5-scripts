#!/bin/sh
cd /tmp
MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} = 'x86_64' ]
then
    URL="http://sourceforge.net/projects/ipscan/files/ipscan3-binary/3.2/ipscan_3.2_amd64.deb"
else
    URL="http://sourceforge.net/projects/ipscan/files/ipscan3-binary/3.2/ipscan_3.2_i386.deb"
fi
FILE="ipscan.deb"
wget -N "$URL" -O $FILE && sudo dpkg -i $FILE -y
#rm $FILE
