bt5-scripts
===========

Included is a set of scripts written for
[BackTrack](http://backtrack-linux.org) 5r3,
though they will likely work on other versions.

All scripts are &copy; Thom Hastings 2012
[New BSD license](http://opensource.org/licenses/BSD-3-Clause).

Here is each script and a short description:

##### after-install.sh
>    This script installs Guake and Tilda, then  calls 
>    several other scripts in the following order:  
>    **./get-tor.sh**  
>    **./get-figlet.sh**  
>    **./get-dropbox.sh**  
>    **./get-chrome.sh**  
>    **./get-audacious.sh**  
>    downloads a handful of wallpapers, runs  
>    **./matrix-boot.sh**  
>    **./get-scripts.sh**  
>    **./get-wordlits.sh**  
>    and starts a BackTrack update script.

##### fix-rtl8187.sh
>    This script follows commands easily found on-line
>    to get the RTL8187 driver working (Alfa AWUS036H)

##### get-audacious.sh
>    This script installs my favourite media player,
>    installs my favourite skins for said player, and
>    creates a shortcut to my favourite stream. (KDE)

##### get-bt5-repos.sh
>    This script grabs the BackTrack 5 GPG key and
>    then adds the BackTrack 5 repositories to your
>    **/etc/apt/sources.list** for non-BT distributions.
>    *** **According to Offensive-Security, this can
>    BREAK your non-BackTrack install. BE FOREWARNED.**

##### get-chrome.sh
>    This script downloads and installs a .deb for
>    Google's Chrome browser. I am still trying to
>    include in the script modifying the binary so
>    that Google Chrome can be run as root

##### get-dropbox.sh
>    This script downloads and begins the first run
>    of Dropbox

##### get-figlet.sh
>    This script installs the figlet ASCII Art text
>    generator and downloads **.flf** figlet fonts from
>    [textfiles.com](http://textfiles.com/art)

##### get-scripts.sh
>    Creates the dir **/pentest/scripts** and downloads
>    Bl4ck5w4n's BT5r3-compatible update script[¹][1] as
>    well as phillips321's set of pentest scripts[²][2],
>    Snafu's pentest, wireless, & ISO master ones[³][3],
>    Alexander Hanel's extflow.py for analyzing TCP[⁴][4],
>    the PenTBox tool[⁵][5], Gentil Kiwi's mimikatz[⁶][6], 
>    scripts from g0tmi1k[⁷][7] including fakeap-pwn[⁸][8],
>    nessus and nmap scripts from pentestgeek[⁹][9], and jigsaw[¹⁰][10],
>    the tools from TrustedSec[¹¹][11] including Artillery,
>    Martin Bosslet's hash-flooding DoS tool schadcode[¹²][12],
>    lnxg33k's webhandler[¹³][13], and the OSINT tool "creepy"[¹⁴][14]

##### get-tor.sh
>    This script installs and configures both [Tor](http://torproject.org)
>    and Privoxy and installs torsocks for the **usewithtor** command

##### get-wordlists.sh
>    This script gets reusable.py[¹⁵][15] for people who use the same
>    pass for different sites, TAPE's wordlist-manipulator[¹⁶][16],
>    grabs a number of good wordlists and then checks out
>    the SVN reposotiroy for InfoSec Daily's wordlists[¹⁷][17]
>    -- this is massive, and will *not* fit on your HDD
>    without a dedicated BackTrack install

##### matrix-boot.sh
>    This script does customizations of GRUB and BootSplash.

[1]: http://bl4ck5w4n.tk/?p=44 "Bl4ck5w4n's BT5 update script"
[2]: http://phillips321.googlecode.com "phillips321's pentest scripts"
[3]: http://configitnow.com/snippets "Snafu's scripts"
[4]: http://hooked-on-mnemonics.blogspot.jp/2012/04/extflowpy-hack-for-carving-files-from.html "extflow.py blog post"
[5]: http://www.pentbox.net "PenTBox"
[6]: http://blog.gentilkiwi.com/mimikatz "Gentil Kiwi's Mimikatz"
[7]: http://code.google.com/p/g0tmi1k "g0tmi1k's scripts"
[8]: http://code.google.com/p/fakeap-pwn "g0tmi1k's fakeap-pwn"
[9]: https://github.com/pentestgeek/scripts "pentestgeek nessus and nmap scripts"
[10]: https://github.com/pentestgeek/jigsaw "pentestgeek jigsaw"
[11]: http://www.trustedsec.com/downloads/tools-download/ "TrustedSec Tools Download"
[12]: http://emboss.github.com/blog/2012/12/14/breaking-murmur-hash-flooding-dos-reloaded/ "schadcode"
[13]: https://github.com/lnxg33k/webhandler "lnxg33k's webhandler"
[14]: http://ilektrojohn.github.com/creepy/ "creepy"
[15]: https://dazzlepod.com/reusable/ "reusable.py"
[16]: http://adaywithtape.blogspot.com/2012/10/manipulating-wordlists-with-wlm.html "TAPE's wordlist-manipulator"
[17]: http://www.isdpodcast.com/resources/62k-common-passwords "InfoSec Daily Podcast's 62k common passes"

More information about me:  
http://turing.slu.edu/~hastint
