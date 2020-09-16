#!/usr/bin/python3
import requests
from bs4 import BeautifulSoup as bs
from subprocess import call

url_voa = "https://www.youtube.com/user/VOAchina/videos"
url_wz = "https://www.youtube.com/channel/UCtAIPjABiQD3qjlEl1T5VpA/videos"
url_jf = "https://www.youtube.com/channel/UCa6ERCDt3GzkvLye32ar89w/videos"

voa = requests.get(url_voa)
wenzhao = requests.get(url_wz)
jiangfeng = requests.get(url_jf)

contents_voa = voa.text
contents_wenzhao = wenzhao.text
contents_jiangfeng = jiangfeng.text

soup_voa = bs(contents_voa, 'html.parser')
soup_wenzhao = bs(contents_wenzhao, 'html.parser')
soup_jiangfeng = bs(contents_jiangfeng, 'html.parser')

items_voa = soup_voa.findAll('li', attrs={"class":"channels-content-item yt-shelf-grid-item"})
items_wenzhao = soup_wenzhao.findAll('h3', attrs={'class':'yt-lockup-title '})
items_jiangfeng = soup_jiangfeng.findAll('h3', attrs={'class':'yt-lockup-title '})

for index, item in enumerate(items_voa):
  time = item.find('span', attrs={"class":"video-time"})
  if time:
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

print("\n \n")

for index, item in enumerate(items_jiangfeng):
  link = "https://www.youtube.com" + item.find('a').attrs['href']
  print("Title: " + item.text + "      " + "URL: " + link + "\n")
  if index == 20:
    break
