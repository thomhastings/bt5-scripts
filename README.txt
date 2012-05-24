Included is a set of scripts written for BackTrack 5r2,
though they will likely work on other versions.

All scripts are (c) Thom Hastings 2012 New BSD license

Below is each script's name and a short description:

after-install.sh
    This script calls several other scripts in the
    following order:
    ./get-wifite.sh
    ./get-tor.sh
    ./get-figlet.sh
    ./get-wordlists.sh
    ./get-scripts.sh
    It then installs Yakuake and Dropbox, then starts
    a Back|Track update script.

fix-rtl8187.sh

    This script follows commands easily found on-line
    to get the RTL8187 driver working (Alfa AWUS036H)

get-bt5-repos.sh

    This script grabs the BackTrack 5 GPG key and
    then adds the BackTrack 5 Repositories to your
    /etc/apt/sources.list for non-BT distributions.

    *** According to Offensive-Security, this can
    BREAK your non-BackTrack install. BE FOREWARNED.

get-figlet.sh

    This script downloads the figlet ASCII Art text
    generator as well as the fonts from textfiles.com

get-scripts.sh

    Creates the dir /pentest/scripts and downloads
    Bl4ck5w4n's BT5r2-compatible update script¹ as
    well as phillips321's set of pentest scripts²,
    Snafu's pentest, wireless, & ISO master ones³,
    Alexander Hanel's extflow.py for analyzing TCP⁴,
    the PenTBox tool⁵, the mysterious mimikatz⁶, and
    gives an option to install Rel1k's Artillery⁷

get-tor.sh

    This script downloads and configures both Tor
    (The Onion Router) and Privoxy as well as
    torsocks for the "usewithtor" command

get-wifite.sh

    This script opens an SVN repository in the
    /pentest/wireless/wifite directory, this is my
    favorite wireless pentesting script

get-wordlists.sh

    This script grabs a number of good wordlists and
    then creates an SVN repo for InfoSec Daily's
    wordlists⁸--this is huge, and will not fit on
    HDD without a dedicated BackTrack install

start-armitage.sh

    This problem may have been resolved by now,
    but there used to be an issue with starting
    Armitage with MSF's postgresql backend and
    this script was designed to alleviate that

1.) http://bl4ck5w4n.tk/?p=44
2.) http://phillips321.googlecode.com
3.) http://configitnow.com/snippets
4.) http://hooked-on-mnemonics.blogspot.jp/2012/04/extflowpy-hack-for-carving-files-from.html
5.) http://www.pentbox.net
6.) http://blog.gentilkiwi.com/mimikatz
7.) https://www.secmaniac.com
8.) http://www.isdpodcast.com/resources/62k-common-passwords

More information about me:
http://turing.slu.edu/~hastint/
