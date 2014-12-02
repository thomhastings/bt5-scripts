#!/bin/sh
# base git subtree script
# for AttackVector-Linux
# run as cron.daily build
# (c) Kenneth Soona GPL v3

# prerequisites: git >= 1.8 (for git subtree)

# TODO: WHOLE SCRIPT NEEDS DEBUGGING

# TODO: Figure out what stuff should go in what subtree where-- how script should be split
# The "extra goodies" part is unclear, I should probably UML diagram all the sources
# Figure out the high-level design based on Kali's live-build scripts & make git repos for extras
# furthermore, find out if git subtrees can also be handled by means of git-svn for svn repos

WORKINGDIR = `pwd`

# set up initial repo
if [ ! -e "base" ]
then
	mkdir -v base
	cd base
	git init
	cp ../attackvector-linux/README.md . # don't know why git needs this, it's just tempremental
	git commit -m "initial commit"
else
	cd base
fi

# clone TAILS git repo (the easy part)
if [ ! -e "tails" ]
then
	git subtree add --prefix=tails git://git.immerda.ch/amnesia.git HEAD
	git subtree split --prefix=tails --branch=feature/pentest
	# trying to add a branch to the tails subtree... might garner develpoment from the TAILS community
	git commit -a -m "add TAILS subtree"
else
	git subtree pull --prefix=tails git://git.immerda.ch/amnesia.git devel
	# merge changes from devel branch into the feature/pentest branch of the tails subtree
	git commit -a -m "TAILS subtree pull"
fi

# clone Kali repos (the clean part)
if [ ! -e "tails/kali" ]
then
	mkdir -v tails/kali
	ln -s tails/kali kali
	git commit -a -m "add Kali subtrees dir"
fi
for LINE in `curl http://git.kali.org/gitweb/?a=project_index | sort`
do
	if [ ! -e "tails/kali/`echo $LINE | awk -F. '{print $1}'`" ]
		git subtree add --prefix=tails/kali/`echo $LINE | awk -F. '{print $1}'` git://git.kali.org/$LINE HEAD
		git commit -a -m "add Kali subtree `echo $LINE | awk -F. '{print $1}'`"
	else
		git subtree pull --prefix=tails/kali/`echo $LINE | awk -F. '{print $1}'` git://git.kali.org/$LINE master
		git commit -a -m "Kali subtree `echo $LINE | awk -F. '{print $1}'` pull"
	fi
done

# clone extra goodies (the messy part)
if [ ! -e "tails/pentest" ]
then
	mkdir -v tails/pentest
	ln -s $WORKINGDIR/tails/pentest $WORKINGDIR/extras
	git commit -a -m "add extra pentest tools dir"
	git svn clone http://armitage.googlecode.com/svn/trunk/ armitagei
    # is git svn the best way to handle svn repos? can these be subtrees?
    git commit -a -m "add latest armitage source"
    if [ ! -e "tails/pentest/scan" ]
		mkdir -v tails/pentest/scan
		git commit -a -m "add extra scanners dir"
		git subtree add --prefix=tails/pentest/scan/recon-ng https://bitbucket.org/LaNMaSteR53/recon-ng.git HEAD
		git commit -a -m "add extra subtree recon-ng"
		# TODO: add codtitional statement like main TAILS, Kali for subtree pull vs subtree add
		git subtree add --prefix=tails/pentest/scan/wpscan git://github.com/wpscanteam/wpscan.git HEAD
		git commit -a -m "add extra subtree wpscan"
		# TODO: add codtitional statement like main TAILS, Kali for subtree pull vs subtree add
		git subtree add --prefix=tails/pentest/scan/dotdotpwn git://github.com/wireghoul/dotdotpwn.git HEAD
		git commit -a -m "add extra subtree dotdotpwn"
		# TODO: add codtitional statement like main TAILS, Kali for subtree pull vs subtree add
		git subtree add --prefix=tails/pentest/scan/omphalos git://github.com/dankamongmen/omphalos.git HEAD
		git commit -a -m "add extra subtree omphalos"
		# TODO: add codtitional statement like main TAILS, Kali for subtree pull vs subtree add
		cd tails/pentest/scan
		mkdir unicornscan
		cd unicornscan
		wget -N http://unicornscan.org/releases/unicornscan-0.4.7-2.tar.bz2
		bzip2 -cd unicornscan-0.4.7-2.tar.bz2 | tar xf -
		#cd unicornscan-0.4.7 	# this should be done during install
		#./configure CFLAGS=-D_GNU_SOURCE
		#make
		#make install
		cd .. #/..
		git commit -a -m "add extra unicornscan"
		mkdir b4ltazar
		cd b4ltazar
		wget -r -l1 -H -t1 -nd -N -np -A.py -erobots=off http://b4ltazar.us/codes/
		chmod +x *.py
		git commit -a -m "add extra b4ltazar scripts"
		mkdir cgi-scanner
		cd cgi-scanner
		wget -N http://josh.myhugesite.com/static/docs/cgi-scanner.py
		chmod +x cgi-scanner.py
		cd ..
		git commit -a -m "add extra cgi-scanner.py"
		mkdir cgi-scanner
		cd cgi-scanner
		wget -N http://codepad.org/BYdtDf9c/raw.py -O extflow.py
		chmod +x extflow.py
		cd ..
		git commit -a -m "add extra extflow.py"
		cd $WORKINGDIR/base
	fi
	if [ ! -e "tails/pentest/dos" ]
		mkdir tails/pentest/ddos
		git commit -a -m "add extra dos dir"
		git subtree add --prefix=tails/pentest/ddos/schadcode git://github.com/emboss/schadcode.git HEAD
		git commit -a -m "add extra subtree schadcode"
		# TODO: add codtitional statement like main TAILS, Kali for subtree pull vs subtree add
		cd tails/pentest/ddos
		git svn clone http://r-u-dead-yet.googlecode.com/svn/trunk r-u-dead-yet
		# is git svn the best way to handle svn repos? can these be subtrees?
		git commit -a -m "add extra svn r-u-dead-yet"
		git svn clone svn://svn.code.sf.net/p/pyloris/code/trunk pyloris
		# is git svn the best way to handle svn repos? can these be subtrees?
		git commit -a -m "add extra svn pyloris"
		mkdir torshammer
		cd torshammer
		wget -N http://packetstormsecurity.com/files/download/98831/torshammer.tgz
		tar xvf torshammer.tgz
		chmod +x *.py
		cd ..
		git commit -a -m "add extra torshammer"
		mkdir slowloris
		cd slowloris
		wget -N http://ha.ckers.org/slowloris/slowloris.pl
		chmod +x slowloris.pl
		cd ..
		git commit -a -m "add slowloris.pl"
		mkdir xerxes
		cd xerxes
		wget -N http://pastebin.com/raw.php?i=MLFs5m1K -O xerxes.c
		gcc xerxes.c -o xerxes
		git commit -a -m "add extra xerxes"
		cd $WORKINGDIR/base
	fi
		if [ ! -e "tails/pentest/misc" ]
		mkdir -pv tails/pentest/misc/pentestgeek
		git commit -a -m "add extra misc dir"
		git subtree add --prefix=tails/pentest/misc/pentestgeek/scripts git://github.com/pentestgeek/scripts.git HEAD
		git commit -a -m "add extra subtree pentestgeek"
		# TODO: add codtitional statement like main TAILS, Kali for subtree pull vs subtree add
		git subtree add --prefix=tails/pentest/misc/pentestgeek/jigsaw git://github.com/pentestgeek/jigsaw.git HEAD
		git commit -a -m "add extra subtree jigsaw"
		# TODO: add codtitional statement like main TAILS, Kali for subtree pull vs subtree add
		cd tails/pentest/misc
		git svn clone http://phillips321.googlecode.com/svn/trunk phillips321
		# is git svn the best way to handle svn repos? can these be subtrees?
		git commit -a -m "add extra phillips321 scripts"
		git svn clone http://g0tmi1k.googlecode.com/svn/trunk g0tmi1k
		# is git svn the best way to handle svn repos? can these be subtrees?
		git commit -a -m "add extra g0tmi1k scripts"
		mkdir snafu
		cd snafu
		svn clone http://hydrafy.googlecode.com/svn/trunk hydrafy
		# is git svn the best way to handle svn repos? can these be subtrees?
		svn clone http://quickset.googlecode.com/svn/trunk quickset
		# is git svn the best way to handle svn repos? can these be subtrees?
		git commit -a -m "add extra snafu scripts"
		mkdir b4ltazar
		cd b4ltazar
		wget -r -l1 -H -t1 -nd -N -np -A.py -erobots=off http://b4ltazar.us/codes/
		chmod +x *.py
		git commit -a -m "add extra b4ltazar scripts"
		cd $WORKINGDIR/base
	fi
	if [ ! -e "tails/pentest/mitm" ]
		mkdir tails/pentest/mitm
		git commit -a -m "add extra mitm dir"
		git subtree add --prefix=tails/pentest/mitm/FakeDns git://github.com/Crypt0s/FakeDns.git HEAD
		git commit -a -m "add extra subtree FakeDns"
		cd tails/pentest/mitm
		git svn clone http://fakeap-pwn.googlecode.com/svn/trunk fakeap-pwn
		# is git svn the best way to handle svn repos? can these be subtrees?
		git commit -a -m "add extra svn fakeap-pwn"
		git hg clone https://bitbucket.org/IntrepidusGroup/mallory mallory
		# is git hg the best way to handle mercurial repos? can these be subtrees?
		git commit -a -m "add extra hg mallory"
		cd $WORKINGDIR/base
	fi
	if [ ! -e "tails/pentest/scada" ]
		mkdir -v tails/pentest/scada
		git subtree add --prefix=tails/pentest/scada git://github.com/nxnrt/wincc_harvester.git HEAD
		cd tails/pentest/scada/wincc_harvester
		# cp wincc_harvester.rb $METASPLOIT_INSTALL_DIR = /opt/metasploit/msf3/modules/auxiliary/admin/scada/ ?????
		cd ..
		git commit -a -m "add extra subtree wincc_harvester"
		# TODO: add codtitional statement like main TAILS, Kali for subtree pull vs subtree add
		git svn clone http://plcscan.googlecode.com/svn/trunk plcscan
		# is git svn the best way to handle svn repos? can these be subtrees?
		cd plcscan
		chmod +x *.py
		cd ..
		git commit -a -m "add extra plcscan"
		mkdir -v s7-brute-offline
		cd s7-brute-offline
		wget http://pastebin.com/raw.php?i=0G9Q2k6y -O s7-brute-offline.py
		chmod +x s7-brute-offline.py
		git commit -a -m "add extra s7-brute-offline"
		cd $WORKINGDIR/base
	fi
	if [ ! -e "tails/pentest/shells" ]
		mkdir -v tails/pentest/shells
		git commit -a -m "add extra shells dir"
		git subtree add --prefix=tails/pentest/shells/webhandler git://github.com/lnxg33k/webhandler.git HEAD
		git commit -a -m "add extra subtree webhandler"
		# TODO: add codtitional statement like main TAILS, Kali for subtree pull vs subtree add
		mkdir tails/pentest/shells/sh3ll.org
		cd tails/pentest/shells/sh3ll.org
		wget -r -l1 -H -t1 -nd -N -np -A.zip -erobots=off http://sh3ll.org
		git commit -a -m "add extra sh3ll.org shells"
		cd $WORKINGDIR/base
	fi
	if [ ! -e "tails/pentest/webapp" ]
		mkdir -v tails/pentest/webapp
		git commit -a -m "add extra webapp dir"
		git subtree add --prefix=tails/pentest/webapp/owtf git://github.com/7a/owtf.git HEAD
		git commit -a -m "add extra subtree owtf"
		# TODO: add codtitional statement like main TAILS, Kali for subtree pull vs subtree add
		git subtree add --prefix=tails/pentest/webapp/pgconsole git://github.com/pentestgeek/pgconsole.git HEAD
		git commit -a -m "add extra subtree pgconsole"
		# TODO: add codtitional statement like main TAILS, Kali for subtree pull vs subtree add
	fi
	if [ ! -e "tails/pentest/wifi" ]
		mkdir -v tails/pentest/wifi # TODO: FIX THIS SHIT GET AIRDROP PYLORCON2 http://pastebin.com/ykL61d5j
		git commit -a -m "add extra wifi dir"
		git subtree add --prefix=tails/pentest/wifi/lorcon https://code.google.com/p/lorcon HEAD
		git commit -a -m "add extra subtree lorcon"
		# TODO: add codtitional statement like main TAILS, Kali for subtree pull vs subtree add
		cd tails/pentest/wifi
		git svn checkout http://pylorcon2.googlecode.com/svn/trunk pylorcon2
		# is git svn the best way to handle svn repos? can these be subtrees?
	fi
