#!/bin/sh
# renames and organizes personal log files

LOGFILE=$1
LOGEXT=${LOGFILE##*.}
THUMBEXT=THM
THUMBFILE=${LOGFILE%.*}.$THUMBEXT
FILEDATE=$(date +"%Y%m%d%H%M" -r $LOGFILE)
LOGPATH=~/Videos/Log
DESTFILE=$LOGPATH/$FILEDATE.$LOGEXT

mv $LOGFILE $DESTFILE
if [ -f $THUMBFILE ];
then
  rm $THUMBFILE
  echo cleaned up $THUMBFILE
else
  echo $THUMBFILE not found
fi

echo "moved $LOGFILE to $DESTFILE"

echo "I want to cmpare $LOGEXT to MOV"
if [ "$LOGEXT" = "MOV" ] || [ "$LOGEXT" = "mov" ] || [ "$LOGEXT" = "AVI" ] || [ "$LOGEXT" = "avi" ];then
  ffmpeg2theora $DESTFILE 
  OUT=$?
  if [ $OUT -eq 0 ];then
    echo "lookin' good, cleanup old files"
    trash $DESTFILE
  else
    echo "Something weird happened, ffmpeg2theora exit status $out. Please check files"
  fi
fi
