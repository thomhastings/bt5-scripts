#!/bin/sh
echo -e "Get \e[32mTor\e[0m for \e[31mBack|Track 5r3\e[0m script"
echo -e "\e[37m(c) Thom Hastings 2012 New BSD license\e[0m"
echo
echo "Adding Tor repository..."
echo "deb http://deb.torproject.org/torproject.org lucid main" >> /etc/apt/sources.list
echo
echo "Getting GPG key..."
gpg --keyserver keys.gnupg.net --recv 886DDD89
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
echo
echo "Updating packages..."
sudo apt-get update
echo
echo "Installing tor, torsocks, and privoxy..."
sudo apt-get install tor torsocks tor-geoipdb deb.torproject.org-keyring privoxy -y
echo
echo "Configuring Privoxy for Tor..."
echo "#  Setting up Privoxy for Tor:" >> /etc/privoxy/config
echo "forward-socks4a / 127.0.0.1:9050 ." >> /etc/privoxy/config
echo
echo "Starting Privoxy..."
/etc/init.d/privoxy start
echo
echo -e "\e[32mDONE\e[0m"
echo "Configure your clients with..."
echo -e "Proxy IP \e[33m127.0.0.1\e[0m and port \e[33m8118\e[0m"
echo -e "Running this script multiple times will result in multiple entries in \e[33m/etc/privoxy/config\e[0m"
