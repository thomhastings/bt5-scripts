#!/bin/sh
echo "Get BT5 Repositories script"
echo "(c) Thom Hastings 2012-2013 New BSD License"
echo
echo "Getting GPG key..."
wget http://all.repository.backtrack-linux.org/backtrack.gpg -O- | sudo apt-key add -
echo
echo "Adding main repository..."
sudo echo "deb http://all.repository.backtrack-linux.org revolution main microverse non-free testing" >> /etc/apt/sources.list
MACHINE_TYPE=`uname -m`
echo "Machine type is $MACHINE_TYPE"
if [ ${MACHINE_TYPE} == 'x86_64']
then
    echo "Adding 64 bit repository..."
    sudo echo "deb http://64.repository.backtrack-linux.org revolution main microverse non-free testing" >> /etc/apt/sources.list.d/backtrack.list
else
    echo "Adding 32 bit repository..."
    sudo echo "deb http://32.repository.backtrack-linux.org revolution main microverse non-free testing" >> /etc/apt/sources.list.d/backtrack.list
fi
echo "Adding source repository..."
sudo echo "deb http://source.repository.backtrack-linux.org revolution main microverse non-free testing" >> /etc/apt/sources.list
echo
echo "Updating sources..."
sudo apt-get update
echo
echo "DONE"
