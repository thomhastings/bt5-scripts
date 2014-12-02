#!/bin/sh
cd /tmp
wget -N https://www.soldierx.com/system/files/sxlabs/projects/scryptz0/quicksnap.py_.tar.gz
tar xvf quicksnap.py_.tar.gz
mv quicksnap.py /opt
rm quicksnap.py_.tar.gz