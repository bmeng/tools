#!/bin/bash
SSDJT_URL="https://www.youtube.com/playlist?list=PL2CGrIfYxHqWUbZDnNEATTp1fpJdkD5wr"
HXLT_URL="https://www.youtube.com/playlist?list=PL2CGrIfYxHqX5_rwWmU_oiW2zAxp7tQQU"
JDDH_URL="https://www.youtube.com/playlist?list=PL2CGrIfYxHqXHU9EZ3ghyLFTUcaYJa3Jd"
MGGC_URL="https://www.youtube.com/playlist?list=PL2CGrIfYxHqUzWZoDhKJzQqRC0VPw6lD0"
DOG_URL="https://www.youtube.com/c/%E7%9C%8B%E4%B8%AD%E5%9B%BD%E7%9A%84%E7%8B%97%E5%93%A5DogChinaShow/videos"
PATTERN="watch\?v=[a-zA-Z0-9_-]{11}"
PREFIX="https://www.youtube.com/"
DATE=`date --iso-8601`
DB_LIST=/root/tools/youtube-dl/db_list.txt
OUTPUT_DIR=/var/www/caddy/audio

#curl "https://www.youtube.com/playlist?list=PL2CGrIfYxHqWUbZDnNEATTp1fpJdkD5wr" -s | egrep -o "watch\?v=[a-zA-Z0-9]{11}" | head -5


for l in $SSDJT_URL $HXLT_URL $JDDH_URL $MGGC_URL $DOG_URL
do
  videos=`curl $l -s | egrep -o $PATTERN | head -5`
    for i in $videos
    do
      video=${PREFIX}$i
      grep $i $DB_LIST
      if [[ $? == 0 ]]
        then continue
      else
        echo $video >> $DB_LIST
        youtube-dl -x -o "$OUTPUT_DIR/$DATE-%(title)s.%(ext)s" $video
      fi
    done
done
