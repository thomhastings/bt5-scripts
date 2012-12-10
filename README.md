bt5-scripts.git
===============

Included is a set of scripts written for [BackTrack](http://backtrack-linux.org) 5r3,
though they will likely work on other versions.

All scripts are &copy; Thom Hastings 2012 New BSD license

Below is each script's name and a short description:

###### after-install.sh
>    This script calls several other scripts in the
>    following order:  
>    ./get-tor.sh  
>    ./get-figlet.sh  
>    ./get-wordlists.sh  
>    ./get-scripts.sh  
>    it then installs Tilda and Dropbox, downloads
>    a handful of wallpapers, does customizations of GRUB and BootSplash, runs  
>    ./get-audacious.sh  
>    and then starts a BackTrack update script.

###### fix-rtl8187.sh
>    This script follows commands easily found on-line
>    to get the RTL8187 driver working (Alfa AWUS036H)

###### get-audacious.sh
>    This script installs my favourite media player,
>    installs my favourite skins for said player, and
>    creates a shortcut to my favourite stream.

###### get-bt5-repos.sh
>    This script grabs the BackTrack 5 GPG key and
>    then adds the BackTrack 5 Repositories to your
>    /etc/apt/sources.list for non-BT distributions.
>    *** **According to Offensive-Security, this can
>    BREAK your non-BackTrack install. BE FOREWARNED.**

###### get-figlet.sh
>    This script downloads the figlet ASCII Art text
>    generator as well as figlet fonts from textfiles.com

###### get-scripts.sh
>    Creates the dir /pentest/scripts and downloads
>    Bl4ck5w4n's BT5r3-compatible update script[¹][1] as
>    well as phillips321's set of pentest scripts[²][2],
>    Snafu's pentest, wireless, & ISO master ones[³][3],
>    Alexander Hanel's extflow.py for analyzing TCP[⁴][4],
>    the PenTBox tool[⁵][5], Gentil Kiwi's mimikatz[⁶][6], 
>    grabs the Scylla[⁷][7] tool released at DEFCON 20,
>    and gives an option to install Rel1k's Artillery[⁸][8]

###### get-tor.sh
>    This script downloads and configures both [Tor](http://torproject.org)
>    and Privoxy as well as torsocks for the "usewithtor" command

###### get-wordlists.sh
>    This script gets TAPE's wordlist-manipulator[⁹][9],
>    grabs a number of good wordlists and then checks out
>    the SVN repo for InfoSec Daily's wordlists[¹⁰][10]--
>    this is massive, and will *not* fit on HDD without
>    a dedicated BackTrack install

[1]: http://bl4ck5w4n.tk/?p=44 "Bl4ck5w4n's BT5 update script"
[2]: http://phillips321.googlecode.com "phillips321's pentest scripts"
[3]: http://configitnow.com/snippets "Snafu's scripts"
[4]: http://hooked-on-mnemonics.blogspot.jp/2012/04/extflowpy-hack-for-carving-files-from.html "extflow.py blog post"
[5]: http://www.pentbox.net "PenTBox"
[6]: http://blog.gentilkiwi.com/mimikatz "Mimikatz"
[7]: http://code.google.com/p/scylla-v1 "Scylla"
[8]: https://www.secmaniac.com "David Kennedy (Rel1k)"
[9]: http://adaywithtape.blogspot.com/2012/10/manipulating-wordlists-with-wlm.html "TAPE's wordlist-manipulator"
[10]: http://www.isdpodcast.com/resources/62k-common-passwords "InfoSec Daily Podcast's 62k common passes"

More information about me:
http://turing.slu.edu/~hastint