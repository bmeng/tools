#!/usr/bin/python3

import requests
from bs4 import BeautifulSoup as bs
from subprocess import call

url = "https://www.youtube.com/channel/UCghLs6s95LrBWOdlZUCH4qw/videos"
wd = "/root/tools/youtube-dl/"

web = requests.get(url)

contents = web.text

soup = bs(contents, 'html.parser')

items = soup.findAll('h3', attrs={'class':'yt-lockup-title '})

for i in [0, 1, 2, 3]:
  item = items[i]
  link = item.find('a').attrs['href']
  if open(wd+'/stone_tmp.list','r').read().find(link) == -1:
    print("Link not found in file")
    call([wd+"/get-ytb.sh", "https://www.youtube.com"+link, "stone记"])
    f = open(wd+"/stone_tmp.list", "a")
    f.write(link+"\n")
