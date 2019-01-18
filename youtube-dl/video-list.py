#!/usr/bin/python36
import requests 
from bs4 import BeautifulSoup as bs
from subprocess import call

url = "https://www.youtube.com/user/VOAchina/videos"
url2 = "https://www.youtube.com/channel/UCtAIPjABiQD3qjlEl1T5VpA/videos"

voa = requests.get(url)
wenzhao = requests.get(url2)

contents_voa = voa.text
contents_wenzhao = wenzhao.text

soup_voa = bs(contents_voa, 'html.parser')
soup_wenzhao = bs(contents_wenzhao, 'html.parser')

items_voa = soup_voa.findAll('li', attrs={"class":"channels-content-item yt-shelf-grid-item"})
items_wenzhao = soup_wenzhao.findAll('h3', attrs={'class':'yt-lockup-title '})

for index, item in enumerate(items_voa):
  time = item.find('span', attrs={"class":"video-time"})
  minute = int(time.text.split(':')[0])
  if minute > 15:
    link = "https://www.youtube.com" + item.find('h3', attrs={'class':'yt-lockup-title '}).find('a').attrs['href']
    title = item.find('h3', attrs={'class':'yt-lockup-title '}).text
    print("Title: " + title + "      " + "URL: " + link + "\n")

print("\n \n")

for index, item in enumerate(items_wenzhao):
  link = "https://www.youtube.com" + item.find('a').attrs['href']
  print("Title: " + item.text + "      " + "URL: " + link + "\n")
  if index == 2:
    break 
