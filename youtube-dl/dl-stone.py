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

item0 = items[0]
item1 = items[1]

link0 = "https://www.youtube.com" + item0.find('a').attrs['href']
link1 = "https://www.youtube.com" + item1.find('a').attrs['href']

if open(wd+'/stone_tmp.list','r').read().find(link0) == -1:
  print("Link not found in file")
  call([wd+"/get-ytb.sh", link0, "stone记"])
  f = open(wd+"/stone_tmp.list", "w")
  f.write(link0)

if open(wd+'/stone_tmp.list','r').read().find(link1) == -1:
  print("Link not found in file")
  call([wd+"/get-ytb.sh", link1, "stone记"])
  f = open(wd+"/stone_tmp.list", "w")
  f.write(link1)
