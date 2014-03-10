#!/bin/sh
# renames and organizes personal log files

LOGPATH=~/Videos/Log

movelog() {
	LOGFILE=$1
	FILEDATE=$(date +"%Y%m%d%H%M" -r $LOGFILE)
	LOGEXT=${LOGFILE##*.}
	DESTFILE=$LOGPATH/$FILEDATE.$LOGEXT	
	THUMBEXT=THM
	THUMBFILE=${LOGFILE%.*}.$THUMBEXT

	if [ "$LOGEXT" = "MOV" ] || [ "$LOGEXT" = "mov" ] || [ "$LOGEXT" = "AVI" ] || [ "$LOGEXT" = "avi" ];then
		echo checking for $DESTFILE
		if [ -f $DESTFILE ]; then
			echo "Destination file already exists, appending current date..."
			DESTFILE="$LOGPATH/$FILEPATH-$(date +"%Y%m%d%H%M").$LOGEXT"
		else
			echo "all clear!"
		fi
		
		cp $LOGFILE $DESTFILE
		
		if [ -f $THUMBFILE ]; then
			rm $THUMBFILE
			echo cleaned up $THUMBFILE
#		else
#			echo $THUMBFILE not found
		fi

		echo "moved $LOGFILE to $DESTFILE"
		OGGLOG=${DESTFILE%.*}.ogv
		echo "$OGGLOG"
		if [ -f $OGGLOG ]; then
			echo "Destination file already exists, appending current date..."
			OGGLOG="${OGGLOG%.*}-$(date +"%Y%m%d%H%M").ogv"
			echo "$OGGLOG"
		fi
		echo "Renencoding file to OGV..."
		ffmpeg2theora $DESTFILE -o $OGGLOG > /dev/null 2>&1
		echo "Reencode complete!"

		OUT=$?
		if [ $OUT -eq 0 ]; then
			echo "lookin' good, cleaning up source $DESTFILE"
			trash $DESTFILE
		else
			echo "Something weird happened, ffmpeg2theora exit status $out. Please check files"
		fi
	fi
}

if [ -d "$1" ]; then
	INPUTFILES=$1/*
	for f in $INPUTFILES; do
		if [ ${f##*.} = MOV ]; then
			movelog $f
		else
			echo "not an appropriate file type"
		fi
	done
else
	movelog $1
fi

echo
echo "all done!"
