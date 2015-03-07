shameless: http://bit.do/avlinuxdl

bt5-scripts
===========

Included is a set of scripts written for
[BackTrack](http://backtrack-linux.org) 5r3,
though they will likely work on other versions.

All scripts are &copy; Thom Hastings 2011-2013
[New BSD license](http://opensource.org/licenses/BSD-3-Clause).

Here is each script and a short description:

##### after-install.sh
>    This script installs Guake and Tilda,
>    runs these other scripts:  
>    **./get-tor.sh**  
>    **./get-figlet.sh**  
>    **./get-dropbox.sh**  
>    **./get-iron-browser.sh**  
>    **./get-audacious.sh**  
>    **./get-jitsi.sh**  
>    downloads a handful of wallpapers, runs  
>    **./matrix-boot.sh**  
>    **./get-scripts.sh**  
>    **./get-wordlists.sh**  
>    **./get-weapon.sh**
>    and starts a BackTrack update script.

##### fix-rtl8187.sh
>    This script follows commands easily found on-line
>    to get the RTL8187 driver working (Alfa AWUS036H)

##### get-audacious.sh
>    This script installs my favourite media player,
>    installs my favourite skins for said player, and
>    creates a shortcut to my favourite stream

##### get-bt5-repos.sh
>    This script grabs the BackTrack 5 GPG key and
>    then adds the BackTrack 5 repositories to your
>    **/etc/apt/sources.list** for non-BT distributions.
>    **WARNING: According to Offensive-Security, this can
>    BREAK your non-BackTrack install. BE FOREWARNED**

##### get-iron-browser.sh
>    This script downloads and installs a .deb for
>    [SRware Iron](http://www.srware.net/en/software_srware_iron.php)
>    browser. I am still trying to include in the script modifying
>    the binary so that it can be run as root. :-(

##### get-dropbox.sh
>    This script downloads and begins the first run
>    of Dropbox {DEPRECATED} Condi Rice != Reptillian

##### get-figlet.sh
>    This script installs the figlet ASCII Art text
>    generator and downloads **.flf** figlet fonts from
>    [textfiles.com](http://textfiles.com/art)

##### get-scripts.sh
>    Creates the dir **/pentest/scripts** and downloads
>    Bl4ck5w4n's BT5r3-compatible update script[¹][1] as
>    well as phillips321's set of pentest scripts[²][2],
>    Snafu's pentest, wireless, & ISO master ones[³][3],
>    DotDotPwn directory traversal fuzzer[⁴][4],
>    OWASP's Offensive (Web) Testing Framework[⁵][5],
>    Alexander Hanel's extflow.py for analyzing TCP[⁶][6],
>    the PenTBox tool[⁷][7], Gentil Kiwi's mimikatz[⁸][8],
>    scripts from g0tmi1k[⁹][9] including fakeap-pwn[¹⁰][10],
>    lnxg33k's webhandler[¹¹][11], Mallory MitM proxy[¹²][12],
>    Martin Bosslet's hash-flooding DoS tool schadcode[¹³][13],
>    pentestgeek's jigsaw[¹⁴][14], nessus and nmap scripts[¹⁵][15],
>    Joshua Begleiter's directory traversing cgi-scanner.py[¹⁶][16],
>    the "tool for network enumeration and domination" Omphalos[¹⁷][17],
>    a few tools for pentesting SCADA ICS[¹⁸][18], and Recon-ng[¹⁹][19]

##### get-tor.sh
>    This script installs and configures both [Tor](http://torproject.org)
>    and Privoxy and installs torsocks for the **usewithtor** command

##### get-wordlists.sh
>    This script gets reusable.py[²⁰][20] for people who use the same
>    pass for different sites, TAPE's wordlist-manipulator[²¹][21],
>    grabs couple of good wordlists and then checks out the
>    SVN repository for InfoSec Daily's wordlists[²²][22]
>    while wgetting every wordlist from SkullSecurity.org[²³][23]
>    **WARNING: This is massive, and will _not_ fit on your HDD
>    without a dedicated BackTrack install!**

##### matrix-boot.sh
>    This script does customizations of GRUB and BootSplash
>    and sets your wallpaper to the [Hacker Manifesto](http://www.mithral.com/~beberg/manifesto.html). :-)

##### start-red-team.sh
>    I found this script on BT forums it starts Armitage Teamserver.

[1]: http://bl4ck5w4n.tk/?p=44 "Bl4ck5w4n's BT5 update script"
[2]: http://phillips321.googlecode.com "phillips321's pentest scripts"
[3]: http://configitnow.com/snippets "Snafu's scripts"
[4]: http://dotdotpwn.blogspot.com "DotDotPwn Directory Traversal Fuzzer"
[5]: https://www.owasp.org/index.php/OWASP_OWTF "OWASP OWTF"
[6]: http://hooked-on-mnemonics.blogspot.com/2012/10/extflowpy-version-2.html "extflow.py blog post"
[7]: http://www.pentbox.net "PenTBox"
[8]: http://blog.gentilkiwi.com/mimikatz "Gentil Kiwi's Mimikatz"
[9]: http://code.google.com/p/g0tmi1k "g0tmi1k's scripts"
[10]: http://code.google.com/p/fakeap-pwn "g0tmi1k's fakeap-pwn"
[11]: https://github.com/lnxg33k/webhandler "lnxg33k's webhandler"
[12]: http://intrepidusgroup.com/insight/mallory/ "Mallory Man-in-the-Middle Proxy"
[13]: http://emboss.github.com/blog/2012/12/14/breaking-murmur-hash-flooding-dos-reloaded/ "schadcode"
[14]: https://github.com/pentestgeek/jigsaw "pentestgeek jigsaw"
[15]: https://github.com/pentestgeek/scripts "pentestgeek nessus and nmap scripts"
[16]: http://josh.myhugesite.com/blog/18#blog "cgi-scanner.py blog post"
[17]: http://dank.qemfd.net/dankwiki/index.php/Omphalos "Omphalos"
[18]: http://blog.ptsecurity.com/2013/01/ics-security-analysis-new-pentest-tools.html "SCADA tools"
[19]: https://bitbucket.org/LaNMaSteR53/recon-ng "Recon-ng"
[20]: https://github.com/codesburner/reusable "reusable.py"
[21]: http://adaywithtape.blogspot.com/2012/10/manipulating-wordlists-with-wlm.html "TAPE's wordlist-manipulator"
[22]: http://www.isdpodcast.com/resources/62k-common-passwords "InfoSec Daily Podcast's wordlists"
[23]: https://wiki.skullsecurity.org/Passwords "SkullSecurity.org Passwords Wiki"

[http://www.anonymous.army](http://bit.do/openwall)

More information about me:  
[http://thomhastings.com](http://goo.gl/jvly9Y)
