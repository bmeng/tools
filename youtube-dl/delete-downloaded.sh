#!/bin/bash

WORKDIR=/root/tools/youtube-dl
IFS=$(echo -en "\n\b")

for i in `ls /root/audio/`
  do FILE=$($WORKDIR/urlencode.py $i)
    grep $FILE /var/log/caddy/caddy-access.log
    if [ $? -eq 0 ]; then
      echo "File downloaded, remove it."
      rm -f /root/audio/$i
    else
      echo "File Has Not Downloaded yet."
    fi
done
