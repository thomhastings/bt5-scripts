#!/bin/sh
echo "Fix RTL8187 driver script"
echo -e "\e[37m(c) Thom Hastings 2011 New BSD license\e[0m"
echo
sudo rmmod rtl8187
sudo rfkill block all
sudo rfkill unblock all
sudo modprobe rtl8187
sudo rfkill unblock all
echo -e "Putting wireless interface \e[33mwlan0\e[0m up..."
ifconfig wlan0 up
echo
echo -e "\e[32mDONE\e[0m"
echo "You may have to run this script multiple times."
