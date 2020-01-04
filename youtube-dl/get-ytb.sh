#!/bin/bash
URL=$1
PREFIX=$2
OUTPUT_DIR="/var/www/caddy/audio"
DATE=`date --iso-8601`

if [[ -z $URL ]]; then
  echo "Usage: $0 URL"
  exit 1
fi

if [[ -z $PREFIX ]]; then
  youtube-dl -x --audio-format mp3 -o "$OUTPUT_DIR/$DATE-$PREFIX-%(title)s.%(ext)s" $URL
else
  youtube-dl -x --audio-format mp3 -o "$OUTPUT_DIR/$DATE-%(title)s.%(ext)s" $URL
fi
