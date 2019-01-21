#!/usr/bin/python

import sys, urllib

name = sys.argv[1]

url = urllib.quote_plus(name)

print url.replace("+", "%20")
