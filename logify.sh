#!/bin/sh
# renames and organizes personal log files

LOGFILE=$1
THUMBEXT=THM
THUMBFILE=${LOGFILE%.*}.$THUMBEXT
FILEDATE=$(date +"%Y%m%d%H%M" -r $LOGFILE)
LOGPATH=~/Videos/Log


mv $LOGFILE $LOGPATH/$FILEDATE.${LOGFILE##*.}

if [ -f $THUMBFILE ];
then
	rm $THUMBFILE
	echo cleaned up $THUMBFILE
else
	echo $THUMBFILE not found
fi

echo moved $LOGFILE to $LOGPATH/$FILEDATE.${LOGFILE##*.}
