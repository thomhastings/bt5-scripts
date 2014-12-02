#!/bin/sh
cd /tmp
wget -N http://s3.amazonaws.com/dmk/dakarand-1.0.tgz
tar xvf dakarand-1.0.tgz
mv dakarand-1.0 dakarand
cd dakarand
sh build.sh
#ln -s dakarand /dev/urandom
cd ..
#rm dakarand
rm dakarand-1.0.tgz