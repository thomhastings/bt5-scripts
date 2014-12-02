#!/bin/bash
#
#deisnged for openSUSE
#may work best as root
#
#work out of temp dir
cd /tmp
mkdir .tmp
ln -s .tmp tmp
cd tmp
#install prerequisities
sudo zypper install tree htop screen zsh lynx vim yakuake audacious figlet p7zip git-core
mkdir WORKING_dir
cd WORKING_dir
git clone git://github.com/thomhastings/bt5-scripts bt5s
git clone git://github.com/thomhastings/os-scripts f0Ss
git clone git://github.com/thomhastings/attackvector avlx
git clone git://github.com/thomhastings/c0ntempt c0rt
git clone git://github.com/kaneda/kinfe knjx
git clone git://github.com/ksoona/attackvector s00n
cd /etc/skel
sudo git clone git://github.com/thomhastings/dotfiles .dot
cd .dot
sudo ./install.sh
cd ..
cd /tmp/tmp/WORKING_dir
git init
git add .
git subtree add --prefix=bt5s backtrack
git subtree add --prefix=f0Ss gotmilkos
git subtree add --prefix=avlx attackvck
git subtree add --prefix=c0rt cortanamk
git subtree add --prefix=knjx joshkando
git subtree add --prefix=s00n kensoona0
git subtree add --prefix=.dot mydotfile
git commit -a -m "added primary base subtrees"
cd ..
rm WORKING_dir
