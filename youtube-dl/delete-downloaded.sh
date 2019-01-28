#!/bin/bash

WORKDIR=/root/tools/youtube-dl
IFS=$(echo -en "\n\b")

for i in `ls /root/audio/`
  do
    PARTNAME=`echo $i | cut -d: -f2- | tr -d ' '`
    FILE=$($WORKDIR/urlencode.py $PARTNAME)
    grep $FILE /var/log/caddy/caddy-access.log
    if [ $? -eq 0 ]; then
      echo "File downloaded, remove it."
      rm -f /root/audio/$i
    else
      echo "File Has Not Downloaded yet."
    fi
done
