#!/bin/sh
# ref url: http://www.phillips321.co.uk/2012/08/28/making-backtrack5-look-like-xp/
cd /tmp
wget -N http://www.phillips321.co.uk/downloads/LookLikeXP.deb && sudo dpkg -i LookLikeXP.deb -y
#rm LookLikeXP.deb