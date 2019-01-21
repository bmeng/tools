#!/bin/bash

# jq is required to process the json output

# appid and appsecret can be found at http://ai.youdao.com/appmgr.s

word="$*"
appid=
appsecret=
LC_ALL=C
if  [[ $word =~ [a-zA-Z] ]]
then
  salt=`shuf -i 0-9 -n 1`
  sign=`printf '%s' "${appid}${word}${salt}${appsecret}" | md5sum | awk '{print $1}'`
  new_word=`printf '%s' "$word" | sed 's/ /\%20/g'`
  curl -s "http://openapi.youdao.com/api?q=${new_word}&from=EN&to=zh_CHS&appKey=${appid}&salt=${salt}&sign=${sign}" | jq ". | { phonetic: .basic.phonetic, explains: .basic.explains, more: .webdict.url}"
else
  salt=`shuf -i 0-9 -n 1`
  sign=`printf '%s' "${appid}${word}${salt}${appsecret}" | md5sum | awk '{print $1}'`
  curl -s "http://openapi.youdao.com/api?q=${word}&from=zh_CHS&to=EN&appKey=${appid}&salt=${salt}&sign=${sign}" | jq ". | { phonetic: .basic.phonetic, explains: .basic.explains, more: .webdict.url}"
fi
