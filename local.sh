#!/bin/bash

#################################################################################################
### It is generally frowned upon to create a local mirror due the bandwidth that is required.
### One of the alternatives will likely fulfill your needs.
### REMEMBER:
### * Bandwidth is not free for the mirrors. They must pay for all the data they serve you
### => This still applies although you pay your ISP
### => There are many packages that will be downloaded that you will likely never use
### => Mirror operators will much prefer you to download only the packages you need
### * Really please look at the alternatives on this page:
### http://wiki.archlinux.org/index.php?title=Local_Mirror
### If you are ABSOLUTELY CERTAIN that a local mirror is the only sensible solution, then this
### script will get you on your way to creating it.
#################################################################################################

# Configuration
#SOURCE='rsync://kambing.ui.ac.id/archlinux'
SOURCE='rsync://mirror.internode.on.net/archlinux'
#SOURCE='rsync://repo.ukdw.ac.id/archlinux'
#SOURCE='rsync://mirror.rit.edu/archlinux'
#SOURCE='rsync://mirror.us.leaseweb.net/archlinux'
#SOURCE='rsync://ftp.swin.edu.au/archlinux'

DEST='/app'

#BW_LIMIT='100'

REPAOS='pool core extra community multilib testing kde-unstable'

#RSYNC_OPTS="-rtlHvP --delete-after --delay-updates --copy-links --safe-links --max-delete=1000 --bwlimit=${BW_LIMIT} --delete-excluded --exclude=.*"
RSYNC_OPTS="-rtlHPvz --delete-after --delay-updates --max-delete=1000"

LCK_FLE='/tmp/pool-sync.lck'

# Make sure only 1 instance runs
if [ -e "$LCK_FLE" ] ; then
OTHER_PID=`/bin/cat $LCK_FLE`
echo "Another instance already running: $OTHER_PID"
exit 1
fi
echo $$ > "$LCK_FLE"

for REPO in $REPOS ; do
echo
echo ">> Syncing $REPO <<"
/usr/bin/rsync $RSYNC_OPTS ${SOURCE}/${REPO} ${DEST}
done

# Cleanup
/bin/rm -f "$LCK_FLE"
exit 0
