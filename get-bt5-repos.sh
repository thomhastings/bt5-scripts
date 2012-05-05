#!/bin/sh
echo "Get BT5 Repositories Script"
echo "(c) Thom Hastings 2012 New BSD License"
echo
echo "Getting GPG key..."
wget -q http://all.repository.backtrack-linux.org/backtrack.gpg -O- | sudo apt-key add -
echo
echo "Adding main repository..."
echo "deb http://all.repository.backtrack-linux.org revolution main microverse non-free testing" > /etc/apt/sources.list
echo "Adding 32 bit repository..."
echo "deb http://32.repository.backtrack-linux.org revolution main microverse non-free testing" > /etc/apt/sources.list
echo "Adding 64 bit repository..."
echo "deb http://64.repository.backtrack-linux.org revolution main microverse non-free testing" > /etc/apt/sources.list
echo "Adding source repository..."
echo "deb http://source.repository.backtrack-linux.org revolution main microverse non-free testing" > /etc/apt/sources.list
echo
echo "Updating sources..."
apt-get update
echo
echo "DONE"
