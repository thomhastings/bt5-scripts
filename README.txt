Included is a set of scripts written for BackTrack 5r2,
though they will likely work on other versions.

All scripts are (c) Thom Hastings 2012 New BSD license

Below is each script's name and a short description:

fix-rtl8187.sh

    This script follows commands easily found on-line
    to get the RTL8187 driver working (Alfa AWUS036H)

get-figlet.sh

    This script downloads the figlet ASCII Art text
    generator as well as the fonts from textfiles.com

get-scripts.sh

    Creates the dir /pentest/scripts and downloads
    Bl4ck5w4n's BT5r2-compatible update script¹ as
    well as phillips321's set of pentest scripts²,
    Snafu's pentest, wireless, & ISO master ones³,
    the PenTBox tool⁴, and also gives an option to
    install Rel1k's Artillery⁵

get-tor.sh

    This script downloads and configures both Tor
    (The Onion Router) and Privoxy as well as
    torsocks for the "usewithtor" command

get-wifite.sh

    This script opens an SVN repository in the
    /pentest/wireless/wifite directory, this is my
    favorite wireless pentesting script

get-wordlists.sh

    This script grabs a couple good wordlists and
    then creates an SVN repo for InfoSec Daily's
    wordlists--this is huge, and will not fit on
    HDD without a dedicated BackTrack install

start-armitage.sh

    This problem may have been resolved by now,
    but there used to be an issue with starting
    Armitage with MSF's postgresql backend and
    this script was designed to alleviate that

1.) http://bl4ck5w4n.tk/?p=44
2.) http://phillips321.googlecode.com
3.) http://configitnow.com/snippets
4.) http://www.pentbox.net
5.) https://www.secmaniac.com

More information about me:
http://turing.slu.edu/~hastint/
