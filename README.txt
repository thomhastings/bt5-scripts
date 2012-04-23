Included is a set of scripts written for BackTrack 5r1,
though I'm sure they still work on BackTrack 5r2.

Below is each script's name and a short description:

fix-rtl8187.sh

    This script follows commands easily found on-line
    to get the RTL8187 Driver working (Alfa AWUS036H)

get-figlet.sh

    This script downloads the figlet ASCII Art text
    generator as well as the fonts from textfiles.com

get-scripts.sh

    Creates the dir /pentest/scripts and downloads
    Bl4ck5w4n's BT5r2-compatible update script¹ as
    well as phillips321's set of pentest scripts²
    and configitnow's wireless and ISO master ones³

get-tor.sh

    This script downloads and configures both Tor
    (The Onion Router) and Privoxy for proxying
    You may also want to "apt-get install torsocks"

get-wifite.sh

    This script opens an SVN repository in the
    /pentest/wireless/wifite directory, this is my
    favorite wireless pentesting script

start-armitage.sh

    This problem may have been resolved by now,
    but there used to be an issue with starting
    Armitage with MSF's postgresql backend and
    this script was designed to alleviate that

1.) http://bl4ck5w4n.tk/?p=44
2.) http://phillips321.googlecode.com
3.) http://code.google.com/u/109456382173154131184

More information about me:
http://turing.slu.edu/~hastint/
