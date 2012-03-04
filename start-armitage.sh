#!/bin/sh
echo "Start Armitage script"
echo -e "\e[37m(c) Thom Hastings 2011 BSD-license\e[0m"
echo
echo -e "\e[31mKilling\e[0m all postgres..."
killall postgres
echo
echo -e "Starting \e[33mframework-postgres\e[0m..."
rm /opt/framework/postgresql/data/postmaster.pid
rm /opt/framework/postgresql/.s.PGSQL.7175
rm /opt/framework/postgresql/.s.PGSQL.7175.lock
/etc/init.d/framework-postgres start
echo
echo -e "Starting \e[36mArmitage\e[0m..."
armitage &
echo
echo -e "\e[32mDONE\e[0m"
