#!/bin/sh
# renames and organizes personal log files

LOGFILE=$1
FILEDATE=$(date +"%Y%m%d%H%M" -r $LOGFILE)
LOGPATH=~/Videos/Log

mv $LOGFILE $LOGPATH/$FILEDATE.${LOGFILE##*.}
echo moved $LOGFILE to $LOGPATH/$FILEDATE.${LOGFILE##*.}
