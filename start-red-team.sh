#!/bin/bash
# ref url: http://www.backtrack-linux.org/forums/showthread.php?t=38743
clear
echo "************************************************************";
MYIP=`ip route | grep src | awk '{print $9}'`; # Finds your IP
echo "Using "$MYIP" as your IP address for Hosting Armitage Server";
echo "************************************************************";
echo "********************************************************";
echo "**Need a SHARED username; Usually: MSF          ********";
echo "********************************************************";
read MSF
echo "******************************************************";
echo "*****        Need a SHARED password   ****************"
echo "******************************************************";
read PASS
echo "Now Launching metasploit daemon"
# cd /pentest/exploits/framework3/; # not necessary on my install
msfrpcd -S -U "$MSF" -P "$PASS" "$IP";
sleep 2
sh -c "/etc/init.d/mysql start";
#xterm -bg black -fg green -T "Login info" -e 
#echo "Username: "$MSF" Password: "$PASS" IP: "$MYIP"" &>/dev/null &
echo "Now launching Armitage server";
echo "USERNAME: "$MSF"";
echo "PASSWORD: "$PASS"";
echo "IP: "$MYIP"";
xterm -bg black -fg green -T "Armitage Server" -e ./armitage --server "$MYIP" 55553 "$MSF" "$PASS" &>/dev/null &
sleep 10
xterm -bg black -fg green -T "ARMITAGE-FAST AND EASY" -e ./armitage &>/dev/null &
