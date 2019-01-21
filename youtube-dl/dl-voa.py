#!/usr/bin/python36

import requests
from bs4 import BeautifulSoup as bs
from subprocess import call

wd = "/root/tools/youtube-dl/"

url = "https://www.youtube.com/user/VOAchina/videos"

web = requests.get(url)

contents = web.text

soup = bs(contents, 'html.parser')

items = soup.findAll('li', attrs={"class":"channels-content-item yt-shelf-grid-item"})

for index, item in enumerate(items):
  time = item.find('span', attrs={"class":"video-time"})
  minute = int(time.text.split(':')[0])
  if minute > 15:
    link = "https://www.youtube.com" + item.find('h3', attrs={'class':'yt-lockup-title '}).find('a').attrs['href']
#    title = item.find('h3', attrs={'class':'yt-lockup-title '}).text
    if open(wd+'voa_tmp.list','r').read().find(link) == -1:
      call([wd+"get-ytb+v.sh", link])
      f = open(wd+'voa_tmp.list','a')
      f.write(link)

