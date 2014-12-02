#!/bin/bash
### BEGIN INIT INFO
# Provides:          sdmem
# Required-Start:
# Required-Stop:     umountfs
# Default-Start:
# Default-Stop:      0 6
# Short-Description: Clear the memory after unmounting everything.
# Description: The tails solution to this seemed too
# 		complicated, so in its place I've written
#		this simple script to erase memory using
#		the sdmem binary from secure-delete at
#		system shutdown.
#		
#		Is swapping out the kern with kexec necessary?
### END INIT INFO
#
# Author: kaneda (kanedasan@gmail.com)
# Date: April 27th 2013

# Wipe the memory quickly
sdmem -ll
