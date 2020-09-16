#!/bin/bash
URL=$1
OPT=$2
WORKDIR="/root/video_download"
OUTPUT_DIR="/var/www/caddy/audio"
DATE=`date --iso-8601`

if [[ -z $URL ]]; then
  echo "Usage: $0 URL"
  exit 1
fi

#NAME=$(you-get -i $URL | grep title | cut -d: -f2- | sed -e 's/^[ \t]*//')

you-get --no-caption -o $WORKDIR $URL

NAME=$(ls $WORKDIR/ | awk -F. '{print $1 }')
EXT=$(ls $WORKDIR/ | awk -F. '{print $NF }')


case $OPT in
  "voa")
    ffmpeg -stats -n -v error -i "$WORKDIR/${NAME}.$EXT" -filter:a "volume=2" "$OUTPUT_DIR/${DATE}-${NAME}.mp3"
  ;;
  "wz")
    ffmpeg -stats -n -v error -i "$WORKDIR/${NAME}.$EXT" "$OUTPUT_DIR/${DATE}-文昭-${NAME}.mp3"
  ;;
  "jf")
    ffmpeg -stats -n -v error -i "$WORKDIR/${NAME}.$EXT" "$OUTPUT_DIR/${DATE}-江峰时刻-${NAME}.mp3"
  ;;
  *)
    echo "Incorrect OPT"
  ;;
esac

rm -f $WORKDIR/*
