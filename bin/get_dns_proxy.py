#!/usr/bin/env python
from lxml import html
import requests

url = 'http://portaller.com'
page = requests.get(url)
tree = html.fromstring(page.content)
print(tree.xpath('//h2/text()')[0].encode("utf8").split('\xa0')[1])
