#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
爬虫练习
'''
__author__ = '付国良'

import os
import Print
# from Print import wn_print, wn_print_line, wn_print_header, wn_print_footer
import urllib
import urllib.request
from collections import deque
import re
import requests




# url = 'http://python.jobbole.com/81102/'
# req = urllib.request.urlopen(url)
# data = req.read()
# data = data.decode('utf-8')
# wn_print(data)



# data = {}
# data['word'] = 'python'
#
# urlValues = urllib.parse.urlencode(data)
# url = 'https://www.baidu.com/s?'
# fullUrl = url + urlValues
# wn_print(fullUrl)
#
# data = urllib.request.urlopen(fullUrl).read()
# data = data.decode('UTF-8')
# with open('/Users/fuguoliang/Desktop/Python/crawler.html', 'a') as f:
#     f.truncate()
#     f.write(data)
#
# os.system('open /Users/fuguoliang/Desktop/Python/crawler.html')
# wn_print('写入文件完成并打开')


# Print.wn_print_header()
#
# queue = deque()
# visited = set()
# url = 'http://baidu.com'
#
# queue.append(url)
# cnt = 0
#
# while queue:
#     url = queue.popleft() # 队首元素出队
#     visited |= {url}
#     cnt += 1
#     print('已经抓取: ' + str(cnt) + '\n' + '正在抓取: ' + url)
#     headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.0; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0'}
#
#     try:
#         urlop = requests.get(url, headers=headers, timeout=30)
#         if 'html' not in urlop.headers['Content-Type']:
#             continue
#         data = urlop.text
#     except:
#         print("发生错误")
#         continue
#
#
#     # 正则表达式提取页面中所有url,并判断是否已经访问过，然后加入待爬队列
#     linkre = re.compile('href=\"(.+?)\"')
#     for x in linkre.findall(data):
#         if 'http' in x and x not in visited:
#             queue.append(x)
#     print('当前剩余: ' + str(len(visited)))
#
# Print.wn_print_footer()


