#!/usr/bin/python3

import requests
from bs4 import BeautifulSoup as bs
from subprocess import call

url = "https://www.youtube.com/channel/UCa6ERCDt3GzkvLye32ar89w/videos"
wd = "/root/tools/youtube-dl/"

web = requests.get(url)

contents = web.text

soup = bs(contents, 'html.parser')

items = soup.findAll('h3', attrs={'class':'yt-lockup-title '})

item0 = items[0]

link = "https://www.youtube.com" + item0.find('a').attrs['href']

print(link)
if open(wd+'/jiangfeng_tmp.list','r').read().find(link) == -1:
  print("Link not found in file")
  call([wd+"/get-ytb.sh", link, "江峰"])
  f = open(wd+"/jiangfeng_tmp.list", "w")
  f.write(link)
